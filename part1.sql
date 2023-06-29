CREATE TYPE diploma_type as enum 
(
	'degree',
	'diploma',
	'certificate'
);

CREATE TABLE public."Program"
(
    "ProgramID" char[10] NOT NULL,
    "NumOfParticipants" integer ,
    "Duration" integer ,
    "Year" integer ,
    "MinCourses" smallint ,
    "MinCredits" integer ,
    "Obligatory" boolean ,
    "CommitteeNum" integer ,
	"DiplomaType" diploma_type ,
    CONSTRAINT "Program_pkey" PRIMARY KEY ("ProgramID")
)

TABLESPACE pg_default;


CREATE TABLE "Offers"
(
	"ProgramID" character[10],
	"Course_code" character(7),
	CONSTRAINT "Offers_fkey1" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID"),
	CONSTRAINT "Offers_fkey2" FOREIGN KEY ("Course_code") REFERENCES "Course"("course_code")
)

TABLESPACE pg_default;

CREATE TABLE "joins"
(
	"ProgramID" character[10] NOT NULL,
	"Student_amka" character varying NOT NULL,
	CONSTRAINT "joins_fkey1" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID"),
	CONSTRAINT "joins_fkey2" FOREIGN KEY ("Student_amka") REFERENCES public."Student"("amka")
)

TABLESPACE pg_default;

CREATE TABLE "Diploma"
(
	"DiplomaNum" integer NOT NULL,
	"DiplomaGrade" integer,
	"DiplomaTitle" integer,
	"ProgramID" character[10] NOT NULL,
	"Student_AMKA" character varying NOT NULL,
	CONSTRAINT "PK_Diploma" PRIMARY KEY ("DiplomaNum", "ProgramID", "Student_AMKA"),
	CONSTRAINT "FK_Diploma_amka" FOREIGN KEY ("Student_AMKA") REFERENCES public."Student"("amka"),
	CONSTRAINT "FK_Diploma_pID" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID")
	
)

TABLESPACE pg_default;

CREATE TABLE "Thesis" 
(
	"Title" character[100],
	"Grade" integer,
	"ThesisID" character[10] NOT NULL,
	"Student_AMKA" character varying NOT NULL,
	"ProgramID" character[10] NOT NULL,
	CONSTRAINT "FK_Thesis_program" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID"),
	CONSTRAINT "FK_Thesis_student" FOREIGN KEY ("Student_AMKA") REFERENCES "Student"("amka"),
	CONSTRAINT "PK_Thesis" PRIMARY KEY ("ThesisID")
)

TABLESPACE pg_default;



CREATE TABLE "ForeignLanguageProgram"
(
	"ProgramID" character[10] PRIMARY KEY NOT NULL,
	"Language" character[20],
	CONSTRAINT "ForeignLanguageProgram_FK" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID")
)

TABLESPACE pg_default;

CREATE TABLE "SeasonalProgram"
(
	"ProgramID" character[10] PRIMARY KEY NOT NULL,
	"Season" character[0],
	CONSTRAINT "SeasonalProgram_FK" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID")
)

TABLESPACE pg_default;

CREATE TABLE "CustomUnits"
(
	"CustomUnitID" character[30] NOT NULL,
	"ProgramID" character[10] NOT NULL,
	CONSTRAINT "CustomUnits_PK" PRIMARY KEY ("CustomUnitID", "ProgramID"),
	CONSTRAINT "CustomUnits_FK_program" FOREIGN KEY ("ProgramID") REFERENCES "Program"("ProgramID")
)

TABLESPACE pg_default;

CREATE TABLE "RefersTo"
(
	"CustomUnitID" character[30] NOT NULL,
	"ProgramID" character[10] NOT NULL,
	"Course_code" character(7) NOT NULL,
	"serial_number" integer NOT NULL,
	CONSTRAINT "RefersTo_PK" PRIMARY KEY ("CustomUnitID", "ProgramID", "Course_code", "serial_number"),
	CONSTRAINT "RefersTo_FK_CourseRun" FOREIGN KEY ("Course_code", "serial_number") REFERENCES "CourseRun"("course_code", "serial_number"),
	CONSTRAINT "RefersTo_FK_CustomUnits" FOREIGN KEY ("CustomUnitID", "ProgramID") REFERENCES "CustomUnits"("CustomUnitID", "ProgramID")
)

TABLESPACE pg_default;
