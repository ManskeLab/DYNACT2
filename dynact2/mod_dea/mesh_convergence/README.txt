Mesh convergence Analysis

Workflow:
  - Create bone meshes (of reference frame) with increasing number of vertices at an increment of 500(or change) each iteration (generate_meshes.py)
    - NOTE: meshes were generated with single bone masks. (Output from volume registration)
  - Create bone surface patch meshes from new mesh (generate_meshes)
  - Choose a frame to run convergence analysis on (high, even contact area)
  - resulting DEA stress values are reported for that frame and analyzed (analyze_mesh_cvg.py)