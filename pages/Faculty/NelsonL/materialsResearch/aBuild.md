---
title:  Installing aBuild
sidebar: mydoc_sidebar
permalink: aBuild.html
toc: true
---

## Obtaining/Installing a copy of aBuild
Make a directory called codes and go into it:
``` bash
mkdir ~/codes
cd ~/codes
```

1.Register for an account on [github][gh].  
2.Navigate to B. Nelson's aBuild repository (found [here][ljnabuild])  
3.Fork B. Nelson's reposity.  This will create a copy of this code
that is yours to edit.  
4.(Back to ML)  Type the following to clone your aBuild repository to
ML:  
```bash
git clone https://github.com/lancejnelson/aBuild.git .
```  
(make sure you replace my username with yours.)  
5.Install aBuild (while in your virtual environment)
```bash
pip install -e ~/codes/aBuild
```


### Copy executables
You will need to copy the following files to your bin

``` bash
~/fsl_groups/fslg_byuimaterials/vasp6_serial
~/fsl_groups/fslg_byuimaterials/mlp
~/fsl_groups/fslg_byuimaterials/enum.x
~/fsl_groups/fslg_byuimaterials/makestr.x
```



[ljnabuild]: https://github.com/lancejnelson/aBuild
[gh]:https://www.github.com  