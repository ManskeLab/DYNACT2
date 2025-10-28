import os
import sys
import argparse
import numpy as np
import scipy, scipy.optimize
import SimpleITK as sitk
import pyvista as pv
from stl import mesh

from sympy import symbols, Eq, solve, log

import matplotlib
from matplotlib import pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm


def compute_gradient_fields():
    pass

def find_cps():
    pass

def derivative_test():
    pass

def get_normal_vector():
    pass

def compute_prinicpal_curvature():
    pass

def main():
    # Fit 5th order, monotone polynomial surface to MC1 and TRP articular surface
    return



def ContourPlot(func, data, fittedParameters):
    f = plt.figure(figsize=(graphWidth/100.0, graphHeight/100.0), dpi=100)
    axes = f.add_subplot(111)

    x_data = data[0]
    y_data = data[1]
    z_data = data[2]

    xModel = np.linspace(min(x_data), max(x_data), 20)
    yModel = np.linspace(min(y_data), max(y_data), 20)
    X, Y = np.meshgrid(xModel, yModel)

    Z = func(np.array([X, Y]), *fittedParameters)

    axes.plot(x_data, y_data, 'o')

    axes.set_title('Contour Plot') # add a title for contour plot
    axes.set_xlabel('X Data') # X axis data label
    axes.set_ylabel('Y Data') # Y axis data label

    CS = matplotlib.pyplot.contour(X, Y, Z, numberOfContourLines, colors='k')
    matplotlib.pyplot.clabel(CS, inline=1, fontsize=10) # labels for contours

    plt.show()
    plt.close('all') # clean up after using pyplot or else thaere can be memory and process problems


def ScatterPlot(data):
    f = plt.figure(figsize=(graphWidth/100.0, graphHeight/100.0), dpi=100)

    matplotlib.pyplot.grid(True)
    axes = Axes3D(f)
    x_data = data[0]
    y_data = data[1]
    z_data = data[2]

    axes = f.add_subplot(111, projection='3d')
    axes.scatter(x_data, y_data, z_data)

    axes.set_title('Scatter Plot (click-drag with mouse)')
    axes.set_xlabel('X Data')
    axes.set_ylabel('Y Data')
    axes.set_zlabel('Z Data')


    plt.show()
    plt.close('all') # clean up after using pyplot or else thaere can be memory and process problems




def SurfacePlot(func, data, fittedParameters):
    f = plt.figure(figsize=(graphWidth/100.0, graphHeight/100.0), dpi=100)

    matplotlib.pyplot.grid(True)
    axes = Axes3D(f)

    x_data = data[0]
    y_data = data[1]
    z_data = data[2]

    # points = np.array([x_data, y_data, z_data])
    # print(points.T)
    # sys.exit()

    # xModel = np.linspace(min(x_data), max(x_data), 20)
    # yModel = np.linspace(min(y_data), max(y_data), 20)
    # X, Y = np.meshgrid(xModel, yModel)

    Z = func(np.array([x_data, y_data]), *fittedParameters)

    points = np.array([x_data, y_data, Z])
    points = points.T

    point_cloud = pv.PolyData(points)
    point_cloud.plot(eye_dome_lighting=True)

    # surf = point_cloud.delaunay_2d(alpha=1.0)
    # surf.plot(show_edges=True)


def func(data, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u):
    # 5th order polynomial
    x = data[0]
    y = data[1]
    return a + b*x + c*y + d*x**2 + e*x*y + f*y**2 + g*x**3 + h*y*x**2 + \
            i*x*y**2 + j*y**3 + k*x**4 + l*y*x**3 + m*(x**2)*(y**2) + \
            n*x*y**3 + o*y**4 + p*x**5 + q*y*x**4 + r*(x**3)*(y**2) + \
            s*(x**2)*(y**3) + t*x*y**4 + u*y**5


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("seg_path", type=str, help="Bone segmentation (STL file)")

    args = parser.parse_args()
    seg_path = args.seg_path

    # 1. VTK NII to VTKPOLYDATA
    
    # 2. extract articular surface (3D Slicer)

    # Load the STL files and add the vectors to the plot
    your_mesh = mesh.Mesh.from_file(seg_path)

    # Remove duplicate/overlapping points
    points = your_mesh.points.reshape([-1, 3])
    point_list = np.unique(points, axis=0)

    x = point_list[:, 0]
    y = point_list[:, 1]
    z = point_list[:, 2]

    # fig = pyplot.figure(figsize=(8, 8))
    # ax = fig.add_subplot(111, projection='3d')
    # ax.scatter(x,y,z)
    # pyplot.show()

    graphWidth = 800 # units are pixels
    graphHeight = 600 # units are pixels

    # 3D contour plot lines
    numberOfContourLines = 16

    xData = x
    yData = y
    zData = z

    data = [xData, yData, zData]

    # here a non-linear surface fit is made with scipy's curve_fit()
    fittedParameters, pcov = scipy.optimize.curve_fit(func, [x,y], z)
    # from string import ascii_uppercase
    # for i, j in zip(popt, ascii_uppercase):
    #     print(f"{j} = {i:.3f}")

    # # ScatterPlot(data)
    SurfacePlot(func, data, fittedParameters)
    # # ContourPlot(func, data, fittedParameters)

    # print('fitted prameters', fittedParameters)

    # modelPredictions = func(data, *fittedParameters) 

    # absError = modelPredictions - zData

    # SE = np.square(absError) # squared errors
    # MSE = np.mean(SE) # mean squared errors
    # RMSE = np.sqrt(MSE) # Root Mean Squared Error, RMSE
    # Rsquared = 1.0 - (np.var(absError) / np.var(zData))
    # print('RMSE:', RMSE)
    # print('R-squared:', Rsquared)




    # fit 5th order polynomial surface to articular surface

    # compute gradient fields

    # find critical points

    # perform 2nd partial derivative test (using Hessian)

    # normal vector at saddle point = Y axis

    # compute principal directions of curvature within 3mm of saddle point
    # get vector averages (x in direction of min curvature, z in direction of maximum curvature)

    # origin = saddle point
    # Z TRP = i_TRP: ulnar-to-radial
    # Y TRP = Z TRP cross k_TRP: distal-to-proximal
    # X TRP = Y TRP cross Z TRP: dorsal-to-volar

    # X MC1 = i_MC1: volar-to-dorsal
    # Y MC1 = k_MC1 cross X MC1: proximal-to-distal
    # Z MC1 = X MC1 cross Y MC1: ulnar-to-radial

    main()