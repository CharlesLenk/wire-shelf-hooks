from scad_export.export import export
from scad_export.exportable import Folder, Model

files=Folder(
    name='scad_export/handy_closet_hook',
    contents=[Model(name='handy_closet_hook', rod_d=rod_d)
              for rod_d in [4 + 0.5 * step for step in range(0, 7)]]
)

export(files)
