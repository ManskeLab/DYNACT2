% ----------------------------------------------------------------
% DEA.m 
%
% Created by: Chris Brunet
% Created on: June 19, 2025
%
% Runs DEA analysis on articular surface meshes and returns joint contact
% stresses
%
% Usage: 
%     1. Follow instructions in readme.md
%     2. Run command: matlab -batch "DEA('{dynact_path}', {volume_no})"
% ----------------------------------------------------------------
function [] = DEA(dynact_path, patient_num)
    %% Script Setup 
    close all
    warning ('off','all');
    
    %% User Defined Variables 
    
    script_path = pwd;
    motions = {'ABAD', 'KEY', 'OPP'};
    
    for m = 1:length(motions)
        motion = motions{m};

        %% Format patient_num with leading zeros
        % This block ensures patient_num is always a 3-digit string (e.g., '001', '010', '100')
        patient_num_numeric = 0;
        if ischar(patient_num) || isstring(patient_num)
            % If patient_num is a string (e.g., '001', '1'), convert to number
            patient_num_numeric = str2double(patient_num);
        elseif isnumeric(patient_num)
            % If patient_num is already a number (e.g., 1, 10)
            patient_num_numeric = patient_num;
        else
            error('Input patient_num must be a number or a string representing a number (e.g., 1, ''001'').');
        end  

        patient_num_formatted = sprintf('%03d', patient_num_numeric);

        %% Initializing File Paths
        disp(' ')
        disp(['PATIENT: ', patient_num_formatted])
        disp(['MOTION: ', motion])
        
        addpath(genpath(script_path))  % Adds everything in this folder, including support functions. 
        dea_files = [dynact_path, sprintf('/DYNACT2_%s/DYNACT2_%s_%s/DEA FILES/Outputs', patient_num_formatted, patient_num_formatted, motion)];

        if ~exist(dea_files, 'dir')
            disp(['Skipping DEA for motion "', motion, '" for patient "', patient_num_formatted, '" because folder does not exist: ', dea_files]);
            continue;
        end

        if ~exist([dea_files, '/DEA_Matlab_Outputs'],'file')  % Creates a folder to save outputs if one doesn't already exist
            mkdir([dea_files, '/DEA_Matlab_Outputs'])
        end
        path_save = ([dea_files, '/DEA_Matlab_Outputs']);
        
        %% Loading Bone & Surface Meshes & JSWs
    
        % loading reference frame details, ie. which frame had the higest avg JSW
        normal_vector_path = [dea_files, '/normal_vector.csv'];
        normal_vector_and_jsw = readmatrix(normal_vector_path)';
        normal_vector = normal_vector_and_jsw(1:3);
        normal_vector = normal_vector / norm(normal_vector);
        mean_jsw = normal_vector_and_jsw(5);
        max_jsw_frame = normal_vector_and_jsw(4) + 1;
    
        initial_translation = mean_jsw*[normal_vector(1) normal_vector(2) normal_vector(3)]; % move mean JSW to touch bones
        initial_translation_matrix = eye(4); 
        initial_translation_matrix(1:3, 4) = initial_translation;
    
        fprintf('\nGETTING .stl FILES FOR VOLUME %d', max_jsw_frame);
        fprintf('\nNormal Vector for MC1 Frame %d: %s', max_jsw_frame, mat2str(normal_vector))
        fprintf('\nAvg JSW for MC1 Frame %d: %f', max_jsw_frame, mean_jsw)
        
        mc1_filename = [dea_files, sprintf('/VOLUME_%d_MC1_MESH.stl', max_jsw_frame)];
        mc1_cart_filename = [dea_files, sprintf('/VOLUME_%d_MC1_PATCH.stl', max_jsw_frame)];
        trp_filename = [dea_files, sprintf('/VOLUME_%d_TRP_MESH.stl', max_jsw_frame)];
        trp_cart_filename = [dea_files, sprintf('/VOLUME_%d_TRP_PATCH.stl', max_jsw_frame)];
        
        mc1_jsw_filename = [dea_files, sprintf('/VOLUME_%d_MC1_PATCH_JSW.xlsx', max_jsw_frame)];
        trp_jsw_filename = [dea_files, sprintf('/VOLUME_%d_TRP_PATCH_JSW.xlsx', max_jsw_frame)];
        
        [mc1.vertices,mc1.faces,~] = STL_Import(mc1_filename); 
        [mc1cart.vertices,mc1cart.faces,~] = STL_Import(mc1_cart_filename);
        [trp.vertices,trp.faces,~] = STL_Import(trp_filename);
        [trpcart.vertices,trpcart.faces,~] = STL_Import(trp_cart_filename);
        
        mc1cart_csv = readtable(mc1_jsw_filename);
        JSW_mc1 = mc1cart_csv.jsw;
        trpcart_csv = readtable(trp_jsw_filename);
        JSW_trp = trpcart_csv.jsw;

        all_forces = zeros(60,7);
        
        % loop through dynact frames
        tic
        for i = 1:60    
            %% Initializing DEA Bone Objects
            %%%%% IMPORTANT %%%%%%
            % for this script, we only load in ONE frame as our DEABone
            % it DOES NOT change across iterations 
           
            mc1Bone = DEABone([ 0 0 0 ], [NaN NaN NaN NaN NaN NaN]); % constructor: center of rotation, boundary conditions
            trpBone = DEABone([ 0 0 0 ], [NaN NaN NaN NaN NaN NaN]); % NaN equals 0 degrees of freedom
        
            mc1Cart = DEAExplicitSurface(mc1cart.vertices,mc1cart.faces);
            trpCart = DEAExplicitSurface(trpcart.vertices,trpcart.faces);
        
            mc1Cart.AddParent(mc1Bone);
            trpCart.AddParent(trpBone);
            
            % DEAContactPair is where the contact stresses are calculated
            % it checks for contact based on the tfm, and then calcs for stress
            % based on cart thickness and material props
            tmcCartPair = DEAContactPair(mc1Cart,trpCart,GenericContactCriteria());
        
            %% Calculating Non-Uniform Cartilage Thickness
            % IMPORTANT: once again we are only doing this for ONE frame
            cart_thickness_mc1 = 1.1 * 0.5 * JSW_mc1;   % 1.1 makes cartilage 10% greather than JSW (due to compression)
            cart_thickness_trp = 1.1 * 0.5 * JSW_trp;   % The 0.5 cuts it in half for each bone
            non_nan_indices_mc1 = ~isnan(cart_thickness_mc1);
            non_nan_indices_trp = ~isnan(cart_thickness_trp);
            non_nan_cart_thickness_mc1 = cart_thickness_mc1(non_nan_indices_mc1);
            non_nan_cart_thickness_trp = cart_thickness_trp(non_nan_indices_trp);
            cart_thickness_mc1_mean = mean(non_nan_cart_thickness_mc1);
            cart_thickness_trp_mean = mean(non_nan_cart_thickness_trp);
        
            % replaces all NaN mean cart thickness
            cart_thickness_mc1(isnan(cart_thickness_mc1)) = cart_thickness_mc1_mean; 
            cart_thickness_trp(isnan(cart_thickness_trp)) = cart_thickness_trp_mean;
        
            mc1Cart.SetSurfThickness(cart_thickness_mc1); 
            trpCart.SetSurfThickness(cart_thickness_trp);
        
            % Sets cartilage elastic modulus. 0.24-1 MPa. Originally was set to 12 MPa, 
            % higher number = less "give" which shows up as more concentrated stress distribution
            E_cart = 1.5; % https://www.sciencedirect.com/science/article/pii/S0268003318310325#:~:text=Cartilage%20Young's%20modulus%20and%20thickness,using%20the%20CA4+%20contrast%20agent. 
            mc1Cart.SetProps(cartMaterialProps(mc1Cart, E_cart,.42));
            trpCart.SetProps(cartMaterialProps(trpCart, E_cart,.42));
        
            %% Initializing Fixed Springs
            % spring1 = DEALinearSpring(100,[1 0 0], 0); % constructor: ligament k value, ligament direction (x,y,z), ligament unstrained length
            % spring1.AddAttachment(DEASpringReferencePoint(trpBone.coR,mc1Bone));
            % spring1.AddAttachment(DEASpringReferencePoint(trpBone.coR,[]));
        
            %% Displacing Bones with Registration Transforms and Computing Contact Stresses
            
            fprintf("\nFRAME: %d", i)

            % Loading transformation matrix
            mc1_tfm_filename = [dea_files, sprintf('/Reference Mesh Transforms/VOL_%d_TO_%d_MC1_TFM.csv', max_jsw_frame, i)];
            trp_tfm_filename = [dea_files, sprintf('/Reference Mesh Transforms/VOL_%d_TO_%d_TRP_TFM.csv', max_jsw_frame, i)];
    
            mc1_transformation_matrix = readmatrix(mc1_tfm_filename);
            trp_transformation_matrix = readmatrix(trp_tfm_filename);
    
            fprintf('\n\tMC1 Reg Tmat: %s', mat2str(mc1_transformation_matrix))
            
            % combining all tfms together
            mc1_combined_tfm = mc1_transformation_matrix * initial_translation_matrix;
            trp_combined_tfm = trp_transformation_matrix;
            
            % converting back into 1x6 array for use in UpdateTform()   
            mc1_tform_for_bone = tfmMat2Arr(mc1_combined_tfm);
            trp_tform_for_bone = tfmMat2Arr(trp_combined_tfm);
    
            %%%%% IMPORTANT %%%%%
            % bones must be overlapping to create contact stress,
            % to do this, we add a fixed transform in the normal vector (towards the TRP)
            % to every Tfm from the registrations
    
            fprintf('\n\tFinal MC1 Transform: %s', mat2str(mc1_tform_for_bone))
            fprintf('\n\tFinal TRP Transform: %s', mat2str(trp_tform_for_bone))
            
            % applying transforms and computing contact forces
            mc1Bone.UpdateTform(mc1_tform_for_bone);
            trpBone.UpdateTform(trp_tform_for_bone);
            tmcCartPair.ComputeContact();
            
            fprintf('\n\tCurrent Forces on Bone: %s', mat2str(mc1Bone.curForces))
            fprintf('\n\tMax Contact Stress: %f MPA\n', max(mc1Cart.curStress))
            
            %% Saving Contact Stresses
            stress_filename = [path_save, sprintf('/VOLUME_%d_MC1_STRESS.xlsx', i)];
            if isfile(stress_filename)
                delete(stress_filename);
            end
            writematrix(mc1Cart.curStress, stress_filename)  

            all_forces(i, :) = [i, mc1Bone.curForces];
        end
        toc
        forces_filename = [path_save, '/FORCES.xlsx'];
        writematrix(all_forces, forces_filename)
    end
% quit;
end