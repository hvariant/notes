# Linux General

## i3 without DE

### default applications

finding out about the mime-type of files:
```
> file --mime-type <file>
```

setting default application:
```
> xdg-mime default pcmanfm.desktop inode/directory
```

## useful scripts

### mouse jiggle

```
#!/usr/bin/env bash
LENGTH=10
DELAY=5
while true
do
    for ANGLE in 0 90 180 270
    do
        xdotool mousemove_relative --polar $ANGLE $LENGTH
        sleep $DELAY
    done
done
```
