set -x

opkg remove bytecode-manager - 1

rm bytecode-manager_1_brcm47xx.ipk

wget http://artea.altervista.org/filodiretto/bytecode-manager_1_brcm47xx.ipk

opkg install bytecode-manager_1_brcm47xx.ipk

set +x
