from datetime import datetime
from distutils.command.sdist import sdist
from re import L
import sqlite3
from tkinter import Menu
from warnings import catch_warnings

#global variables:
con = sqlite3.connect("Kaffe.db")
cursor = con.cursor()

#Product backlog:
#User story 1 completed
#User story 2 completed
#User story 3 completed
#User story 4 completed
#User story 5 NOT completed

#TODO:
#Need to finish US5
#Need to debug and tidy
#Finish writing document
#Adding dummy data and check again. (Clean database)


#The home menu. It shows you the available actions and how to access them.
def menu():

    info = """Velkommen, velg et alternativ fra listen under
    1. Legg ut ett kaffeinnlegg      (1)
    2. Filtrer kaffeinnlegg          (2)
    3. Se statistikk om kaffekonsum  (3)
    4. Logg ut                       (4)"""

    while(True):
        print(info)
        menuchoice = input('Skriv inn et tall fra 1-4 med ønskelig handling ')

        if (menuchoice == '1'):
            coffee_tastying()
            
        elif (menuchoice == '2'):
            filter()
        
        elif (menuchoice == '3'):
            coffee_stats()
        
        elif (menuchoice == '4'):
            print('Du logges nå ut. Ha en fin dag :)')
            break

        else:
            print ('Ikke gyldig svar. Prøv igjen. \n')




def coffee_stats():
    #Print should maybe be more symmertrical
    
    seperator = "\n---------------------------------------------------------------------------------------------------------------------------------------------------------------\n"

    print(seperator)
    print("\nVelkommen til kaffestikk\nHer kan du hente ut statestikk om din og andre sitt kaffekonsum \n")

    alt1 = "- Liste over hvilke av våre brukere som har smakt flest unike kaffer i et bestemt år (1)"
    alt2 = "- Kaffer som gir deg mest for pengene                                                (2)"
    
    choice = input("Velg et alternativ fra menyen: \n" + alt1 + "\n" + alt2 + "\n: ")
    
    
    if (choice == '1'):
        year = int(input("Hvilket år vil du se statistikk fra? "))

        #User story 2
        cursor.execute("""
        SELECT Fornavn, Etternavn, COUNT(DISTINCT Kaffe.kaffeId) AS AntallUnikeKaffer 
        FROM Bruker NATURAL JOIN Kaffesmak 
        INNER JOIN Kaffe ON (kaffesmak.kaffeId == kaffe.kaffeId) 
        WHERE Kaffesmak.Aar = ? ORDER BY AntallUnikeKaffer DESC""", (year,))

        data1 = cursor.fetchall()

        print ("\nEn tabell over antall unike kaffer smakt i " + str(year) +": \n")
        print("Fornavn | Etternavn | Antall unike kaffer" )
        
        for row in data1:
            print(str(row[0]) + ' | ' + str(row[1]) + ' | ' + str(row[2]))
        
        print ("\n")

    elif (choice == "2"):

        #User story 3
        cursor.execute("""
        SELECT Kaffebrenneri.navn AS Brennerinavn, Kaffe.navn AS Kaffenavn, Kilopris, AVG(Poeng) AS Gjennomsnittscore 
        FROM Kaffesmak INNER JOIN Kaffe ON (Kaffesmak.kaffeId = Kaffe.KaffeId) 
        INNER JOIN Kaffebrenneri ON (Kaffe.BrenneriId = Kaffebrenneri.BrenneriId) 
        ORDER BY Gjennomsnittscore DESC, Kilopris ASC""")

        data = cursor.fetchall()
        
        print("\nEn liste med brennerinavn, kaffenavn, pris og gjennomsnittscore for hver kaffe:\n")

        print("Brennnerinavn | Kaffenavn | Kilopris | Gjennomsnittscore")
        for row in data:
            print(str(row[0]) + ' | ' + str(row[1]) + ' | ' + str(row[2]) + ' | ' + str(row[3]))
        
        print("\n")
    
    else:
        print("Det var ikke et alternativ.")

    print(seperator)
    




def filter():
     
    seperator = "\n---------------------------------------------------------------------------------------------------------------------------------------------------------------\n"

    print(seperator)

    print("\nVelkommen til filtering\nHer kan du filtrere etter spesifikke beskrivelser for kaffer eller notiser av andre \n")

    alt1 = "- Søke etter spesifikk beskrivelse eller notater om en kaffe (1)"
    alt2 = "- Finne kaffe med ønsket land og filtere bort foredlingsmetode (2)"

    choice = input("Velg et alternativ fra menyen: \n" + alt1 + "\n" + alt2 + "\n: ")

    if(choice == "1"):
    #User story 4
    #The print could need some formatting
        word = "%" + input("\nSkriv inn hvilket ord du ønsker å finne\n") + "%"
        cursor.execute("""SELECT DISTINCT Kaffebrenneri.Navn AS Brennerinavn,  Kaffe.Navn AS Kaffenavn
                   FROM Kaffe INNER JOIN KaffeSmak ON Kaffe.KaffeId = Kaffesmak.KaffeId
                   INNER JOIN Kaffebrenneri ON Kaffebrenneri.BrenneriId = Kaffe.BrenneriId
                   WHERE (Notater LIKE ? OR Beskrivelse LIKE ?)""", (word, word,))
                   
        data = cursor.fetchall()
        
        print("\nEn liste med brennerinavn og kaffenavn for hver kaffe:\n")
        
        print("Brennnerinavn | Kaffenavn")
        for row in data:
            print(str(row[0]) + ' | ' + str(row[1]))
            print("\n")


    elif(choice == "2"):
        #Userstory 5
        method = input("Hvilken metode ønsker du at ikke skal være brukt? \n")
        print("Du kan velge to land du ønsker kaffen skal være fra \n: ")
        country1 = input("Første landet:\n ")
        country2 = input("Andre landet:\n ")
    

        #Has a str error. Think maybe the input on countries must be done differently
        #Filtering away method is not done and must be
        cursor.execute("""SELECT DISTINCT Kaffebrenneri.Navn AS Brennerinavn,  Kaffe.Navn AS Kaffenavn
                        FROM Gaard INNER JOIN Kaffeparti ON Kaffeparti.GaardId = Gaard.GaardId
                        INNER JOIN Foredlingsmetode ON Kaffeparti.MetodeId = Foredlingsmetode.MetodeId
                        INNER JOIN Kaffe ON Kaffe.PartiId = Kaffe.PartiId
                        INNER JOIN Kaffebrenneri ON Kaffebrenneri.BrenneriId = Kaffe.BrenneriId
                        Where Foredlingsmetode.Navn NOT LIKE ? AND (Land = ? OR Land = ?)""", (method, country1, country2 ))

        data = cursor.fetchall()

        print("\nEn liste med brennerinavn og kaffenavn for hver kaffe:\n")
        
        print("Brennnerinavn | Kaffenavn \n")
        for row in data:
            print(str(row[0]) + ' | ' + str(row[1]))
            print("\n")
        
    else:
        print("Det var ikke et alternativ. Skriv inn på nytt")


    print(seperator)


def login():
    choice = input('Skriv inn l om du ønsker å logge inn og r om du ønsker å registrere deg \n ')
    if choice == 'l':
        state = True
        while (state):
            try:
                email = input('E-postadresse: ')
                password = input('Passord: ')
                global current_user
                cursor.execute("SELECT BrukerId FROM Bruker WHERE Epost = ? AND Passord = ? ", (email, password,))
                current_user = cursor.fetchone()[0]
                state = False
            except TypeError:
                sign_up = input("Ikke registrert deg? Ønsker du å registrere deg (j/n)")
                if(sign_up == 'j'):
                    state = False
                    signup()

    elif choice == 'r':
        signup()
    else:
        print('Dette er ikke en gyldig input prøv igjen')
        login()
        


def signup():
    email = input('E-postadresse: ')
    firstname = input('Fornavn: ')
    surname = input('Etternavn: ')
    password = input('Passord: ')
    cursor.execute("SELECT MAX(BrukerId) FROM Bruker")
    lastId = cursor.fetchone()[0] +1
    global current_user
    current_user = lastId
    cursor.execute('''INSERT INTO Bruker(BrukerId, Fornavn, Etternavn, Epost, Passord) VALUES (?,?,?,?,?)''',(lastId, firstname, surname, email, password))
    con.commit()
    print("\n")

#Validation for date:
def validate_date(day, month, year):
    date = (str(year) + '-' + str(month) + '-' + str(day))

    try:
        datetime.strptime(date, "%Y-%m-%d")

    except ValueError:
         raise Exception("Ugylding dato")


def coffee_tastying(): 
    print("Registrer kaffesmakingen din")

    try:
        coffee_name = input('Kaffe navn: ')
        coffee_description = input('Beskrivelse: ')
        coffee_score = int(input('Poengsum (1-10): '))
        coffee_distillery = input('Kaffebrenneri: ')

        #Date input:
        coffee_tastying_day = int(input('Smaksdag (dd): '))
        coffee_tastying_month = int(input('Smaksmåned (mm): '))
        coffee_tastying_year = int(input('Smaksår (yyyy): '))

        #Validering av dato:
        validate_date(coffee_tastying_day, coffee_tastying_month, coffee_tastying_year)
        

        cursor.execute("SELECT MAX(SmakId) FROM KaffeSmak")
        lastId = cursor.fetchone()[0] +1
        cursor.execute("SELECT BrenneriId FROM Kaffebrenneri WHERE Navn = ?", (coffee_distillery,))
        coffee_distillery_id = cursor.fetchone()[0]
        cursor.execute("SELECT KaffeId FROM Kaffe WHERE Navn = ? AND BrenneriId = ? ", (coffee_name, coffee_distillery_id,))
        coffee_id = cursor.fetchone()[0]
    
        cursor.execute('''INSERT INTO kaffesmak(SmakId, Notater, Poeng, Dag, Maaned, Aar, BrukerId, KaffeId) VALUES (?,?, ?,?,?,?,?,?)''',(lastId, coffee_description, coffee_score, coffee_tastying_day, coffee_tastying_month, coffee_tastying_year, current_user, coffee_id))
        con.commit()

        print('\nDitt innlegg ble registrert.\n')

    except Exception:
        print("\nDitt innlegg ble ikke registrert. Sjekk at du har gyldig dato(dd,mm,yyyy), kaffenavn, kaffebrenneri og poengsum.\n")
        

def main():
    login()
    menu()
    con.close()


if __name__ == "__main__":
    main()
