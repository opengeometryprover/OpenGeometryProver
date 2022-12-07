/*
 * libogpgddm.hpp
 *
 * Implementation of the Geometric Deductive Database Method (GDDM) as a
 * library.
 *
 * This file is part of the OGP GDDM prover, which, in turn, is part of
 * the Open Geometry Prover Community Project (OGPCP)
 * <https://github.com/opengeometryprover>.
 *
 * Copyright (C) 2022 Nuno Baeta, Pedro Quaresma
 * Distributed under GNU GPL 3.0 or later
 */


#include "strs.hpp"


struct strsList *points = NULL;
struct strsList *ndg = NULL;


int ogpgddm(char *);
