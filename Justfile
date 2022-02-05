previews:
    #!/bin/dash
    for i in $(find . -name *.scad); do
        d=$(printf '%s\n' "$i" | sed 's/.scad/.png/')
        echo "Rendering $i"
        OpenSCAD -o "$d" -D 'quick=false' "$i"
    done