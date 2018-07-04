# Partition

Use NTFS for Windows ISOs.

```
fdisk /dev/sdX
    p
        check the size and stuff, making sure its the right disk
    d
        whatever partitions are there
    n
        accept defaults (p, etc)
    t
        7 for ntfs, or c for fat32
    a
        make it bootable
    p
        see the changes
    w
        write the changes
```


# Format

## NTFS

```
mkfs.ntfs /dev/sdX1
```

## FAT32

```
mkfs.vfat /dev/sdX1
```


# Mount

```
mkdir /mnt/somewhere
mount /dev/sdX1 /mnt/somewhere
```


# Label

```
sudo dosfslabel /dev/sdXY "SOME LABEL"
```
