# Normal_mode_disp
The repository will be advancing on codes related to many normal mode operations of molecules (Post processing

Executables:-<br>
1. data.sh:-<br>
data.sh takes the eigenvectors of nth frequncy mode from a gaussian log file (GAUSSIAN VERSION: 16).<br>

bash terminal command:-<br>
$ ./data.sh -i &lt;gaussianfilename.log&gt; -n &lt;nth frequency&gt;

2. displace.py:<br>
Matrix scaling and addition<br>

bash terminal command:<br>
$ python3 displace.py &lt;filename1&gt; &lt;filename2&gt; &lt;filename3&gt; &lt;scale_uptp&gt; &lt;scale_step&gt;

3. atomless.sh:<br>
Removing atom list

4. atommerge.sh:<br>
Creates .com files into out folder

5. driver.sh
The main driver code which runs all the above codes to proide n * m .com files 

bash terminal command:<br>
$ ./driver.sh -i &lt;logfile&gt; -n &lt;nthfreq&gt; -m &lt;mthfreq&gt;

