/*
 * ogpgddm.cpp
 *
 * Implementation of the Geometric Deductive Database Method (GDDM).
 *
 * This file is part of the OGP GDDM prover, which, in turn, is part of
 * the Open Geometry Prover Community Project (OGPCP)
 * <https://github.com/opengeometryprover>.
 *
 * Copyright (C) 2022 Nuno Baeta, Pedro Quaresma
 * Distributed under GNU GPL 3.0 or later
 */


#include <cstdlib>
#include <ctime>
#include <iostream>
#include <map>
#include <string>

#include <sqlite3.h>

#include "dbRAM.hpp"
#include "foftodb.hpp"
#include "parser.hpp"
#include "prover.hpp"
#include "strs.hpp"
#include "version.hpp" // defines VERSION


struct strsList *points = NULL;
struct strsList *ndg = NULL;

void errorMsg(int error) {
    std::cerr << "[OGPGDDM ERROR " << error << "] ";
    switch (error) {
    case 1:
	std::cerr << "Incorrect number of argumentos.";
	std::cerr << " Use option '-h' for help." << std::endl;
	break;
    }
    exit(error);
}


/*
 * Auxiliary function to assist in the backup of the in-memory databse to file
 * both input values are the return value of a sqlite3 function
 * --> remaining : int, number of pages left to copy
 * --> pagecount : int, total number of pages in the source database
 * <-- void, writes the progress (in percentage) of the backup to stdout.
 */
void xProgress(int remaining, int pagecount){
  double completion;
  completion =  (double) (pagecount - remaining) / pagecount*100; // 100% *
  std:: cout << "completion: " << completion << "%" << std::endl;
}



int main(int argc, char *argv[]) {
    double time_spent;
    bool proved;
    clock_t start_t, end_t,proved_t;
    std::string argone;
    DBinMemory dbim;
    Driver drv;
    FOFtoDB fdb;
    Prover ogpgddm;
    const char* zFilename = "dbMemToFile.db";

    std::cout << "OGP GDDM " << VERSION << std::endl;
    std::cout << "Copyright (C) 2022 Nuno Baeta, Pedro Quaresma" << std::endl;
    std::cout << "Distributed under GNU GPL 3.0 or later" << std::endl;

    if (argc < 2) {
	errorMsg(1);
    } else {
	if (argv[1] == std::string("-h") || argv[1] == std::string("--help")) {
	    std::cout << std::endl;
	    std::cout << "Usage:" << std::endl;
	    std::cout << "    ogpgddm [option | conjecture]" << std::endl;
	    std::cout << "where option is one of:" << std::endl;
	    std::cout << "    -h | --help     this help" << std::endl;
	    std::cout << "    -V | --version  OGP GDDM's version" << std::endl;
	    exit(EXIT_SUCCESS);
	} else if (argv[1] == std::string("-V")
		   || argv[1] == std::string("--version")) {
	    // Nothing to do, just exit with success.
	    exit(EXIT_SUCCESS);
	} else if (argv[1] == std::string("-p")) {
	    drv.trace_parsing = true;
	} else if (argv[1] == std::string("-s")) {
	    drv.trace_scanning = true;
	} else if (!drv.parse(argv[1])) {
	    // Code to be executed when everything goes correctly
	} else {
	    // Code to be executed when an error occurs while parsing
	    return 2;
	}
    }

    start_t = clock();

    // Open and create the database (in memory)
    dbim.openInMemoryDB();
    dbim.createDBforGDDM();

    // Populate the database
    dbim = fdb.readFileLoadDB(drv, dbim);

    // DEBUG START
    // Backup the database (before begin)
    //    dbim.backupDb(zFilename,xProgress);
    // DEBUG STOP

    // Calculate fixed point
    dbim = ogpgddm.fixedPoint(dbim,&proved_t );

    end_t = clock();
    time_spent = ((double)(end_t - start_t))/CLOCKS_PER_SEC;

    proved = ogpgddm.proved(dbim);
    
    // Final report (if proved it was already wrote)
    if (proved) {
      std::cout << "Conjecture is PROVED, in: ";
      std::cout << ((double)(proved_t - start_t))/CLOCKS_PER_SEC << "s" << std::endl;
    }
    else {
	std::cout << "Conjecture is: NOT PROVED" << std::endl;;
    }
    std::cout << "Fix-point found, in: ";
    std::cout << ((double)(end_t - start_t))/CLOCKS_PER_SEC << "s" << std::endl;
    argone.assign(argv[1]);
    ogpgddm.saveFixedPoint(dbim, argone);
    // Close the database
    dbim.closeDB();

    exit(EXIT_SUCCESS);
}
