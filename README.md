# Normal_mode_disp
The repository will be advancing on codes related to many normal mode operations of molecules (Post processing

Executables:-<br>
1. data.sh:-<br>
data.sh takes the eigenvectors of nth frequncy mode from a gaussian log file (GAUSSIAN VERSION: 16).<br>

bash terminal command:-<br>

```shell
$ ./data.sh -i gaussianfilename.log -n nth frequency
```

2. displace.py:<br>
Matrix scaling and addition<br>

bash terminal command:<br>
```shell
$ python3 displace.py filename1 filename2 filename3 scale_from scale_step scale_to
```
3. atomless.sh:<br>
Removing atom list

4. atommerge.sh:<br>
Creates .com files into out folder

5. driver.sh
The main driver code which runs all the above codes to proide n * m .com files 

bash terminal command:<br>

```shell
$ ./driver.sh -i logfile -n nthfreq -m mthfreq
```
