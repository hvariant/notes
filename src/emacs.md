# Emacs

## Org mode

### summing over column

make the table:
```
| title                                     | price |
|-------------------------------------------+-------|
| leviathan and air-pump                    | 41.43 |
| the social construction of reality        | 23.60 |
| protestant ethic and spirit of capitalism | 28.16 |
|-------------------------------------------+-------|
| total                                     |       |
```

then move the cursor to the `price` column of the `total` row
and type:
```
C-c =
vsum(@I..@II)
```

which will add the following formula to the bottom of the table:
```
#+TBLFM: $2=vsum(@I..@II)
```

to refresh, redo `C-c =` and use the same formula from auto-complete.

## General Usage

### killing multiple buffers

Open \*Buffers list\* using `ls`, then mark buffers to kill using `d`.
Use normal evil commands to navigate the list.

Once finished, press `x` to commit the changes.
