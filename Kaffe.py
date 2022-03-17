from distutils.command.sdist import sdist
import sqlite3
from tkinter import Menu


con = sqlite3.connect("Kaffe.db")
cursor = con.cursor()


#The home menu. It shows you the available actions and how to access them.
def menu():

    info = """Velkommen, velg et alternativ fra listen under
    1. Legg ut ett kaffeinnlegg (1)
    2. Filtrer kaffeinnlegg (2)
    3. Personlig kaffestikk (3)
    4. Logg ut (4)"""

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
            print ('Ikke gyldig svar. Prøv igjen.')




def coffee_stats():
    print("""Velkommen til kaffestikk.
    Her kan du hente ut statestikk om din og andre sitt kaffekonsum""")

    personal_stats = input('Statestikk om eget konsum (j/n)')
    
    if (personal_stats == 'j'):
        con.execute("SELECT * FROM bruker")
        


def filter():
    todo = 'todo'


def login():
    choice = input('Skriv inn l om du ønsker å logge inn og r om du ønsker å registrere deg \n ')
    if choice == 'l':
        email = input('E-postadresse: ')
        password = input('Passord: ')
        global current_user
        cursor.execute("SELECT BrukerId FROM Bruker WHERE Epost = ? ", (email,))
        current_user = cursor.fetchone()[0]
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


def coffee_tastying(): 
    print("Registrer kaffesmakingen din")
    coffee_name = input('Kaffe navn: ')
    coffee_description = input('Beskrivelse: ')
    coffee_score = int(input('Poengsum (1-10): '))
    coffee_distillery = input('Kaffebrenneri: ')
    coffee_tastying_day = int(input('Smaksdag (dd): '))
    coffee_tastying_month = int(input('Smaksmåned (mm): '))
    coffee_tastying_year = int(input('Smaksår (yyyy): '))
    cursor.execute("SELECT MAX(SmakId) FROM KaffeSmak")
    lastId = cursor.fetchone()[0] +1
    cursor.execute("SELECT BrenneriId FROM Kaffebrenneri WHERE Navn = ?", (coffee_distillery,))
    coffee_distillery_id = cursor.fetchone()[0]
    cursor.execute("SELECT KaffeId FROM Kaffe WHERE Navn = ? AND BrenneriId = ? ", (coffee_name, coffee_distillery_id,))
    coffee_id = cursor.fetchone()[0]
  
    cursor.execute('''INSERT INTO kaffesmak(SmakId, Notater, Poeng, Dag, Maaned, Aar, BrukerId, KaffeId) VALUES (?,?, ?,?,?,?,?,?)''',(lastId, coffee_description, coffee_score, coffee_tastying_day, coffee_tastying_month, coffee_tastying_year, current_user, coffee_id))
    con.commit()

def main():
    login()
    menu()


if __name__ == "__main__":
    main()