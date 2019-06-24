# Partition

```
fdisk /dev/sdX
    p
        check the size and stuff, making sure its the right disk
    d
        whatever partitions are there
    n
        accept defaults (p, etc)
    t
        83 for ext#, 7 for ntfs, or c for fat32
    a
        make it bootable
    p
        see the changes
    w
        write the changes
```


# Format

## ext4

```
mkfs.ext4 /dev/sdX1
```

## NTFS

```
mkfs.ntfs --quick /dev/sdX1
```

## FAT32

```
mkfs.vfat /dev/sdX1
```


# Mount

```
mkdir /mnt/somewhere
mount -t ext4 /dev/sdX1 /mnt/
```


# Label

```
sudo dosfslabel /dev/sdXY "SOME LABEL"
```
