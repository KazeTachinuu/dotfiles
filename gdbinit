# Quality of life, no magic (from epita-ing1-setup)
set history save on
set history filename ~/.gdb_history
set print pretty on
set pagination off
set confirm off

# GEF when installed (Arch: /usr/share/gef); inert elsewhere
python
import os
for _p in ('/usr/share/gef/gef.py', os.path.expanduser('~/.gef.py')):
    if os.path.exists(_p):
        gdb.execute(f'source {_p}')
        break
end
