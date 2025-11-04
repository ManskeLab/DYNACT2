# ----------------------------------------------------------------
# plot_utils.py 
#
# Created by: Chris Brunet
# Created on: June 19, 2025
#
# Utils used for plotting bone meshes and patches
#
# ----------------------------------------------------------------

import os
import pyvista as pv
import matplotlib.pyplot as plt

def mesh_patch_plot(plotter: pv.Plotter, mesh, patch, scalar, clim, view=None, invert=False, bone_num=1, cmap='turbo_r', color='lightblue'):
    """
    Plots a bone mesh and articular surface patch together on a plot

    Args:
        plotter (pyvista.Plotter): Plotter object where plot is to be applied
        mesh (pyvista.PolyData): bone mesh
        patch (pyvista.PolyData): bone surface patch
        scalar (string): name of data to be read from patch
        clim ([float]): list of upper and lower value to apply colour map
        view (string): axis' which to orient view
        invert (boolean): used to reverse the direction of the view angle
        bone_num (int): used if multiple bones need to be plotted on same Plotter
        cmap (string): used to specify colourmap for surface patch
    """
    plotter.add_mesh(mesh, color=color, show_edges=False, opacity=1, name=f"Mesh{bone_num}")
    plotter.add_mesh(patch, scalars=scalar, clim=clim, cmap=cmap, smooth_shading=True, show_edges=False, opacity=1, name=f"Patch{bone_num}")
    set_view(plotter, view, invert)

def set_view(plotter: pv.Plotter, view, invert):
    """
    Sets the view of plotter

    Args:
        plotter (pyvista.Plotter): Plotter object where view is to be applied
        view (string): axis' which to orient view
        invert (boolean): used to reverse the direction of the view angle
    """
    match view:
        case 'xy': 
            plotter.view_xy(negative=invert)
        case 'xz':
            plotter.view_xz(negative=invert)
        case 'yx':
            plotter.view_yx(negative=invert)
        case 'yz':
            plotter.view_yz(negative=invert)
        case 'zx':
            plotter.view_zx(negative=invert)
        case 'zy':
            plotter.view_zy(negative=invert)

def offset_patches(patches, input='+x'):
    """
    Moves articular surface patch 0.01mm away from bone mesh to prevent overlap when plotting on top of bone mesh

    Args:
        patches ([pyvista.PolyData]): list of surface patches
        input (string): direction of offeset to be applied

    Returns:
        new_patches ([pyvista.PolyData]): list of surface patches with desired offset applied
    """
    new_patches = [None] * len(patches)
    offset_value = 0.01
    direction = input[1]
    if input[0] == '+':
        negative = False
    elif input[0] == '-':
        negative = True
    else:
        print("Input not allowed...")
        return None
    
    if negative:
        offset_value = -offset_value
    for i, patch in enumerate(patches):
        if direction == 'x':  
            new_patches[i] = patch.translate([offset_value, 0, 0], inplace=False)
        elif direction == 'y': 
            new_patches[i] = patch.translate([0, offset_value, 0], inplace=False)
        else:
            new_patches[i] = patch.translate([0, 0, offset_value], inplace=False)

    return new_patches

def plot_bones(bone_1_meshes, bone_2_meshes, bone_3_meshes, bone_1_patches, bone_2_patches, bone_3_patches, scalar_names, cmaps, clim_12, clim_3, views, offsets, plot=False, output_dir=None, gif_filename=None):
    """
    Generates GIF +/- interactive PyVista Plot with 3 subplots:
        1. Bone 1 and Bone 2 isometric view
        2. Bone 1 and Surface Patch view
        3. Bone 3 and Surface Patch view 

    Args:
        bone_1_meshes ([pyvista.Polydata]): list of bone meshes
        bone_2_meshes ([pyvista.Polydata]): list of bone meshes
        bone_3_meshes ([pyvista.Polydata]): list of bone meshes
        bone_1_patches ([pyvista.Polydata]): list of bone patches
        bone_2_patches ([pyvista.Polydata]): list of bone patches
        bone_3_patches ([pyvista.Polydata]): list of bone patches
        scalar_names ([string]): list of scalar names for patch plotting
        clim_jsw ([float]): list of upper and lower value to apply colour map
        clim_stress ([float]): list of upper and lower value to apply colour map
        views ([string]): list of views to apply to each subplot
        offsets ([string]): list of offsets to apply to each list surface patches
        plot (boolean): toggle output of the interactive plot
        output_dir (string): directory where gif should be saved
        gif_filename (string): filename of gif 
    """

    invert = []
    bone_1_patches_offset = offset_patches(bone_1_patches, offsets[0])
    bone_2_patches_offset = offset_patches(bone_2_patches, offsets[1])
    bone_3_patches_offset = offset_patches(bone_3_patches, offsets[2])

    for offset in offsets:
        if offset[0] == "+":
            invert.append(False)
        else:
            invert.append(True)

    if gif_filename and output_dir:
        print(f"\tStarting GIF generation for {len(bone_1_meshes)} volumes...")

        gif_path = os.path.join(output_dir, gif_filename)
        p = pv.Plotter(shape=(1,3), window_size=[1000, 500], off_screen=True)
        p.open_gif(gif_path)

        for idx in range(len(bone_1_meshes)):        
            p.clear()

            p.subplot(0,0)
            p.add_text(f"Frame: {idx+1}")
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_1_meshes[idx], 
                patch=bone_1_patches_offset[idx], 
                scalar=scalar_names[0], 
                clim=clim_12, 
                view=None,
                bone_num=1,
                cmap=cmaps[0]
            )
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_2_meshes[idx], 
                patch=bone_2_patches_offset[idx], 
                scalar=scalar_names[1], 
                clim=clim_12, 
                view=None,
                bone_num=2,
                cmap=cmaps[1],
                color='lightgreen'
            )
            p.view_isometric()

            p.subplot(0,1)
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_1_meshes[idx], 
                patch=bone_1_patches_offset[idx], 
                scalar=scalar_names[0], 
                clim=clim_12, 
                view=views[0],
                invert=invert[0],
                cmap=cmaps[0]
            )

            p.subplot(0,2)
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_3_meshes[idx], 
                patch=bone_3_patches_offset[idx], 
                scalar=scalar_names[2], 
                clim=clim_3, 
                view=views[1], 
                invert=invert[2],
                cmap=cmaps[2]
            )
            
            p.write_frame()

        p.close()

        print(f"\tBone Animation GIF Saved to {gif_path}")

    if plot:
        p = pv.Plotter(shape=(1,3), window_size=[3000, 2000])
        def update_plot(value, widget):
            idx = int(value)
            widget.GetSliderRepresentation().SetValue(idx)  # snap slider to nearest int
            widget.GetSliderRepresentation().SetLabelFormat('%.0f')

            if not (0 <= idx < len(bone_1_meshes)):
                print(f"Invalid slider value: {value}, index {idx} out of range.")
                return

            # Update text for current volume
            p.clear_plane_widgets() 

            p.subplot(0,0)
            p.add_text(f"Frame: {idx+1}", name="frame")
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_1_meshes[idx], 
                patch=bone_1_patches_offset[idx], 
                scalar=scalar_names[0], 
                clim=clim_12, 
                view=None,
                bone_num=1,
                cmap=cmaps[0]
            )
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_2_meshes[idx], 
                patch=bone_2_patches_offset[idx], 
                scalar=scalar_names[1], 
                clim=clim_12, 
                view=None,
                bone_num=2,
                cmap=cmaps[1],
                color='lightgreen'
            )
            p.show_grid()
            p.view_isometric()

            p.subplot(0,1)
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_1_meshes[idx], 
                patch=bone_1_patches_offset[idx], 
                scalar=scalar_names[0], 
                clim=clim_12, 
                view=views[0],
                invert=invert[0],
                cmap=cmaps[0]
            )

            p.subplot(0,2)
            mesh_patch_plot(
                plotter=p, 
                mesh=bone_3_meshes[idx], 
                patch=bone_3_patches_offset[idx], 
                scalar=scalar_names[2], 
                clim=clim_3, 
                view=views[1], 
                invert=invert[2],
                cmap=cmaps[2]
            )

            p.render()

        p.subplot(0,0)
        mesh_patch_plot(
            plotter=p, 
            mesh=bone_1_meshes[0], 
            patch=bone_1_patches_offset[0], 
            scalar=scalar_names[0], 
            clim=clim_12, 
            view=None,
            bone_num=1,
            cmap=cmaps[0]
        )
        mesh_patch_plot(
            plotter=p, 
            mesh=bone_2_meshes[0], 
            patch=bone_2_patches_offset[0], 
            scalar=scalar_names[1], 
            clim=clim_12, 
            view=None,
            bone_num=2,
            cmap=cmaps[1]
        )
        p.show_grid()
        p.view_isometric()

        p.subplot(0,1)
        mesh_patch_plot(
            plotter=p, 
            mesh=bone_1_meshes[0], 
            patch=bone_1_patches_offset[0], 
            scalar=scalar_names[0], 
            clim=clim_12, 
            view=views[0],
            invert=invert[0],
            cmap=cmaps[0]
        )

        p.subplot(0,2)
        mesh_patch_plot(
            plotter=p, 
            mesh=bone_3_meshes[0], 
            patch=bone_3_patches_offset[0], 
            scalar=scalar_names[2], 
            clim=clim_3, 
            view=views[1],
            invert=invert[2],
            cmap=cmaps[2]
        )

        p.add_slider_widget(
                callback=update_plot,
                rng=[0, len(bone_1_meshes) - 1],
                value=0,
                title="Volume Step",
                pointa=(0.6, 0.20),
                pointb=(0.9, 0.20),
                style='modern',
                pass_widget=True,
                interaction_event='always'
            )

        p.show()

def plot_forces(forces_df, displacements, output_dir, filename):
    """
    Plots bone force components, magnitudes, and displacement magnitude over time

    Args:
        forces_df (pandas.DataFrame): dataframe containing Frame, X,Y,Z force components and Magnitude
        displacements ([float]): list of displacement magnitudes
        output_dir (string): directory where png should be saved
        filename (string): filename of png 
    """
    fname = os.path.join(output_dir, filename)
    # smooth forces with rolling avg to reduce noise
    forces_smoothed = forces_df[['Fx', 'Fy', 'Fz', 'magnitude']].rolling(window=4, center=True).mean()

    fig, axs = plt.subplots(3, 1, figsize=(10, 6), sharex=True)
    axs[0].plot(forces_df['Frame'], forces_smoothed['Fx'], label='Fx', color='r')
    axs[0].plot(forces_df['Frame'], forces_smoothed['Fy'], label='Fy', color='g')
    axs[0].plot(forces_df['Frame'], forces_smoothed['Fz'], label='Fz', color='b')
    axs[1].plot(forces_df['Frame'], forces_smoothed['magnitude'], label='Magnitude', color='k')
    axs[2].plot(forces_df['Frame'], displacements, label='MC1 Displacement', color='orange')

    for ax in axs:
        ax.legend()
        ax.grid(True)

    axs[0].set_ylabel("Force, N")
    axs[1].set_ylabel("Force, N")
    axs[2].set_ylabel("Displacement, mm")
    axs[2].set_xlabel("Frame")

    fig.suptitle(f"Force Components, Magnitude & Displacement Over Time ({filename})")
    plt.tight_layout()
    plt.savefig(fname=fname)

    print(f"\tForces and Displacement Curves Saved to {fname}")