

CS6350 Assignment1b-partii:

Keertan Dakarapu
kxd160830

Dileep Gudena
dxg161730


	1. The cluster should already have the wiki_text.txt or any other text file preloaded in a folder with no other file inside it.
	2. The destination folder should not pre exist, and will be created by the program.
	3. The mobyposi.i file should be preloaded in /user/kxd160830 or /user/<net-id> (i.e, the hadoop directory, not local directory)
	4. The Eclipse project has to be loaded as a Maven project in Eclipse and the pom file has to be "Maven Run"
	5. The Jar file created under the Target folder has to be uploaded to your cluster.

Running the Jar file: 
	> hadoop jar assignment1b-0.0.1-SNAPSHOT.jar assignment1b.assignment1b.Ass1b_partii <input text file>  <output destination>

Example: 
	> hadoop jar assignment1b-0.0.1-SNAPSHOT.jar assignment1b.assignment1b.Ass1b_partii /user/kxd160830/Assignment1b_input  /user/kxd160830/Assignment1b_output_final

NOTE:  If the input text file location is a folder, then only the text file needed has to be in it, else specify the file along with the folder name.
	Also, the destination folder should not preexist.

Seeing the output:

	> hadoop dfs -cat <output folder given above>/p*

	Example for our case:
	> hadoop dfs -cat Assignment1b_output_final/p*

NOTE: The output could be seen using -cat on part-r-0000 file, but its better to specify with p*.
