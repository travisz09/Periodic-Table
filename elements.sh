#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

var=$1



elements () {
  #if argument is passed
  if [[ ! -z $1 ]]
  then
    # if var is a number
    if [[ $var =~ ^[0-9]+$ ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$var";)
      #if element data not found
      if [[ -z $NAME ]]
      then
        echo I could not find that element in the database.
      else
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$var";)
        TYPE=$($PSQL "SELECT type FROM types LEFT JOIN properties USING(type_id) LEFT JOIN elements USING(atomic_number) WHERE atomic_number=$var;";)
        MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN elements USING(atomic_number) WHERE atomic_number=$var;";)
        MELT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE atomic_number=$var;";)
        BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE atomic_number=$var;";)

        echo -e "The element with atomic number $var is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      fi
    
    #if var length = 2
    elif [[ ${#var} -le 2  ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$var'";)
      #if element data not found
      if [[ -z $NAME ]]
      then
        echo I could not find that element in the database.
      else
        NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$var'";)
        TYPE=$($PSQL "SELECT type FROM types LEFT JOIN properties USING(type_id) LEFT JOIN elements USING(atomic_number) WHERE symbol='$var';";)
        MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN elements USING(atomic_number) WHERE symbol='$var';";)
        MELT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE symbol='$var';";)
        BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE symbol='$var';";)

        echo -e "The element with atomic number $NUMBER is $NAME ($var). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      fi

    #if var length > 2
    elif [[ ${#var} > 2  ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE name='$var'";)
      #if element data not found
      if [[ -z $NAME ]]
      then
        echo I could not find that element in the database.
      else
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$var'";)
        NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$var'";)
        TYPE=$($PSQL "SELECT type FROM types LEFT JOIN properties USING(type_id) LEFT JOIN elements USING(atomic_number) WHERE name='$var';";)
        MASS=$($PSQL "SELECT atomic_mass FROM properties LEFT JOIN elements USING(atomic_number) WHERE name='$var';";)
        MELT=$($PSQL "SELECT melting_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE name='$var';";)
        BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties LEFT JOIN elements USING(atomic_number) WHERE name='$var';";)

        echo -e "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      fi
    fi


  else
    echo Please provide an element as an argument.
  fi
}

elements $var
