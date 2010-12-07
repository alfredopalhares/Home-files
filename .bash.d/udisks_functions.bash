#!bash

#
# udisks_functions: https://bbs.archlinux.org/viewtopic.php?id=109307
#

# options:
enable_device="true"
enable_mmc="true"
enable_optical="true"
enable_floppy="true"
enable_device_aliases="true"
enable_mmc_aliases="true"

# mount commands:
mount="udisks --mount"
unmount="udisks --unmount"

# device drives:
device="sd[b-j]"

# mmc drives:
mmc="mmcblk[0-9]"

# partitions:
device_partition="[1-9]*"
mmc_partition="p[0-9]*"

# optical drives:
optical="sr[0-2]"

# floppy drives:
floppy="fd[0-2]"

# device aliases:
if [[ $enable_device_aliases = true ]] && [[ $enable_device = true ]]; then
	for a in {b..j}; do
		alias sd"$a"m="sdm sd$a"
		alias sd"$a"u="sdu sd$a"
	done
fi

# mmc aliases:
if [[ $enable_mmc_aliases = true ]] && [[ $enable_mmc = true ]]; then
	for a in {0..9}; do
		alias mc"$a"m="mcm mmcblk$a"
		alias mc"$a"u="mcu mmcblk$a"
	done
fi

# device functions:
if [[ $enable_device = true ]]; then
	sdm() {
		if [[ "$2" ]]; then
			if [[ "$1" = ?d* ]]; then
				if [[ -b /dev/"$1""$2" ]]; then
					$mount /dev/"$1""$2"
				fi
			fi
		elif [[ "$1" ]]; then
			if [[ "$1" = ?d* ]]; then
				if [[ -b /dev/"$1"1 ]]; then
					if [[ "$1" = ????* ]]; then
						$mount /dev/"$1"
					else
						for a in /dev/"$1"$device_partition; do
							$mount "$a"
						done
					fi
				else
					if  [[ -b /dev/"$1" ]]; then
						$mount /dev/"$1"
					fi
				fi
			fi
		else
			for a in /dev/$device; do
				if [[ -b "$a"1 ]]; then
					for b in "$a"$device_partition; do
						$mount "$b"
						done
				else
					$mount "$a"
				fi
			done
		fi
	}

	sdu() {
		if [[ "$2" ]]; then
			if [[ "$1" = ?d* ]]; then
				if [[ -b /dev/"$1""$2" ]]; then
					$unmount /dev/"$1""$2"
				fi
			fi
		elif [[ "$1" ]]; then
			if [[ "$1" = ?d* ]]; then
				if [[ -b /dev/"$1"1 ]]; then
					if [[ "$1" = ????* ]]; then
						$unmount /dev/"$1"
					else
						for a in /dev/"$1"$device_partition; do
							$unmount "$a"
						done
					fi
				else
					if  [[ -b /dev/"$1" ]]; then
						$unmount /dev/"$1"
					fi
				fi
			fi
		else
			for a in /dev/$device; do
				if [[ -b "$a"1 ]]; then
					for b in "$a"$device_partition; do
						$unmount "$b"
						done
				else
					$unmount "$a"
				fi
			done
		fi
	}
fi

# mmc functions:
if [[ $enable_mmc = true ]]; then
	mcm() {
		if [[ "$2" ]]; then
			if [[ "$1" = mmcblk* ]]; then
				if [[ -b /dev/"$1""$2" ]]; then
					$mount /dev/"$1""$2"
				fi
			fi
		elif [[ "$1" ]]; then
			if [[ "$1" = mmcblk* ]]; then
				if [[ -b /dev/"$1"p0 ]]; then
					if [[ "$1" = ???????* ]]; then
						$mount /dev/"$1"
					else
						for a in /dev/"$1"$mmc_partition; do
							$mount "$a"
						done
					fi
				else
					if  [[ -b /dev/"$1" ]]; then
						$mount /dev/"$1"
					fi
				fi
			fi
		else
			for a in /dev/$mmc; do
				if [[ -b "$a"p0 ]]; then
					for b in "$a"$mmc_partition; do
						$mount "$b"
						done
				else
					$mount "$a"
				fi
			done
		fi
	}

	mcu() {
		if [[ "$2" ]]; then
			if [[ "$1" = mmcblk* ]]; then
				if [[ -b /dev/"$1""$2" ]]; then
					$unmount /dev/"$1""$2"
				fi
			fi
		elif [[ "$1" ]]; then
			if [[ "$1" = mmcblk* ]]; then
				if [[ -b /dev/"$1"p0 ]]; then
					if [[ "$1" = ???????* ]]; then
						$unmount /dev/"$1"
					else
						for a in /dev/"$1"$mmc_partition; do
							$unmount "$a"
						done
					fi
				else
					if  [[ -b /dev/"$1" ]]; then
						$unmount /dev/"$1"
					fi
				fi
			fi
		else
			for a in /dev/$mmc; do
				if [[ -b "$a"p0 ]]; then
					for b in "$a"$mmc_partition; do
						$unmount "$b"
						done
				else
					$unmount "$a"
				fi
			done
		fi
	}
fi

# optical functions:
if [[ $enable_optical = true ]]; then
	srm() {
		if [[ "$1" ]]; then
			if [[ "$1" = ? ]]; then
				if [[ -b /dev/sr"$1" ]]; then
					$mount /dev/sr"$1"
				fi
			fi
		else
			for a in /dev/$optical; do
				if [[ -b "$a" ]]; then
					$mount "$a"
				fi
			done
		fi
	}

	sru() {
		if [[ "$1" ]]; then
			if [[ "$1" = ? ]]; then
				if [[ -b /dev/sr"$1" ]]; then
					$unmount /dev/sr"$1"
				fi
			fi
		else
			for a in /dev/$optical; do
				if [[ -b "$a" ]]; then
					$unmount "$a"
				fi
			done
		fi
	}
fi

# floppy functions:
if [[ $enable_floppy = true ]]; then
	fdm() {
		if [[ "$1" ]]; then
			if [[ "$1" = ? ]]; then
				if [[ -b /dev/fd"$1" ]]; then
					$mount /dev/fd"$1"
				fi
			fi
		else
			for a in /dev/$floppy; do
				if [[ -b "$a" ]]; then
					$mount "$a"
				fi
			done
		fi
	}

	fdu() {
		if [[ "$1" ]]; then
			if [[ "$1" = ? ]]; then
				if [[ -b /dev/fd"$1" ]]; then
					$unmount /dev/fd"$1"
				fi
			fi
		else
			for a in /dev/$floppy; do
				if [[ -b "$a" ]]; then
					$unmount "$a"
				fi
			done
		fi
	}
fi

