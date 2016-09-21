
%Students = cell(39,4);

Students = { '	Amir	Abadi	 '
 '	Khalid	Al-Tailji	 '
 '	Bashar	Alaoudi Sr	 '
 '	Essa	Alkandari	 '
 '	Abdulrahman	Althebeany	 '
 '	David	Beard	 '
 '	Almuhannad	Binsaied	 '
 '	Cesar	Canales	 '
 '	Jordan	Chan	 '
 '	Jake	Cleaveland	 '
 '	Carlos	Colina Barazarte	 '
 '	Francisco	Gulart	 '
 '	Shawn	Davidson	 '
 '	Jose	Garcia	 '
 '	Mukhiya	Gurung	 '
 '	Ryan	Gutierrez	 '
 '	Nicholas	Hinson	 '
 '	Michael	Hong	 '
 '	Michael	Kamel	 '
 '	Pyi	Khin	 '
 '	David	LaBree	 '
 '	Jungrock	Lee	 '
 '	Kevin	Li	 '
 '	Chris	Lim	 '
 '	Clayton	Lopez	 '
 '	Edward	Mark	 '
 '	Elliott	Marx	 '
 '	Daniel	Putney	 '
 '	Eduardo	Ramirez	 '
 '	Mohammed	Saiyed	 '
 '	Noah	Sato	 '
 '	Aaron	Schnittger	 '
 '	Rachel	Stoerkel	 '
 '	Yuki	Takahashi	 '
 '	Emmanuel	Veloz	 '
 '	Van	Williams	 '
 '	Jonathan	Wong	 '
 '	Jiajing	Wu	 '
 '	Rachel	Yee	 '};

Relationships = combnk(Students,2);%Calculate and group all combinations of students.
Similarities = cell(741,3);% Create cell    R = cell(size(rows of relationships),size(columns of relationships)+1);

Similarities(1:741,1) = Relationships(1:741,1);%Copy first column
Similarities(1:741,2) = Relationships(1:741,2)%Copy second column

%All students data

