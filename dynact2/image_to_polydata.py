import os
import vtk
import argparse


def nifti_reader(input_path):
    nifti_reader = vtk.vtkNIFTIImageReader()
    nifti_reader.SetFileName(input_path)
    nifti_reader.Update()

    return nifti_reader.GetOutput()


def marching_cubes(vtk_image):
    marching_cubes = vtk.vtkMarchingCubes()
    marching_cubes.SetInputData(vtk_image)
    marching_cubes.ComputeNormalsOn()
    marching_cubes.SetValue(0, 1)
    marching_cubes.Update()
    surface = marching_cubes.GetOutput()

    return surface


def polydata_writer(polydata_surface, output_path):
    polydata_writer = vtk.vtkPolyDataWriter()
    polydata_writer.SetInputData(polydata_surface)
    polydata_writer.SetFileName(output_path)
    polydata_writer.Update()


def main(image_path, polydata_path):
    image = nifti_reader(image_path)
    surface = marching_cubes(image)
    polydata_writer(surface, polydata_path)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("image_path", type=str, help="Segmentation image file (NIFTI image)")

    args = parser.parse_args()
    image_path = args.image_path

    output_dir = os.path.dirname(image_path)
    basename = os.path.splitext(os.path.basename(image_path))[0]
    polydata_path = os.path.join(output_dir, basename + ".vtk")

    main(image_path, polydata_path)
