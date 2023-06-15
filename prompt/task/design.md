# Task: Design a new feature

To trim prompt lengths, allow attention.txt file to request "iface" for markdown files,
in which case only the section named "Interface" will be included.
If there is no such section, or when requesting "full", the full file will be displayed.
The default is "iface".

Examples:

/doc/smpl.md
/doc/smpl2.md full
/doc/smpl2.md iface

