from scad_export.exportable import Folder, Model, export

# Export a hook for multiple wire rod diameters in 0.5mm increments, starting at 4mm and ending at 7mm.
files=Folder(
    name='scad_export/handy_closet_hook',
    contents=[Model(name='handy_closet_hook', rod_d=rod_d)
              for rod_d in [4 + 0.5 * step for step in range(0, 7)]]
)

export(files)
