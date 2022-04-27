#Antes de iniciar:
#Ejecutar la siguiente ruta por concola:
    #cd C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe
    #"mysql.exe" -uroot -p nombre_de_mi_bd
#show databases para buscar en nombre de la base da datos a la cual se va a hacer la conexion 

import json
import pymysql
import os

class Database:
    def __init__(self):
        self.connection = pymysql.connect(
            host= 'localhost', 
            user='root',
            password='esteban',
            db= 'matricula_javeriana'
        )
        
        self.cursor = self.connection.cursor()

        print("conexion exitosa, puede revisar los archivos json generados")


#Listar todos los cursos ofrecidos en la carrera de Ingeniería de Sistemas mostrando la siguiente información: el nombre del curso, el profesor que dicta el curso, en que salón se dictará y a qué hora (tener en cuenta que un mismo curso puede ser dictado por profesores diferentes, en horarios diferentes y en salones diferentes).

    def puntoA(self):
        sql= 'SELECT  nombre_curso, nombre_carrera, nombre, apellido, numero_salon, nombre_edificio FROM curso INNER JOIN carrera ON idcarrera = carrera_idcarrera INNER JOIN profesor ON profesor.id_profesor = curso.profesor_id_profesor INNER JOIN usuarios ON usuarios.id = profesor.usuarios_id1 INNER JOIN franja_horaria ON franja_horaria.curso_idcurso = curso.idcurso INNER JOIN salon ON salon.id_salon = franja_horaria.salon_numero_salon INNER JOIN edificio ON edificio.id_edificio = salon.edificio_id_edificio WHERE nombre_carrera = "ingenieria de sistemas"'
        # , nombre_carrera, nombre, apellido, numero_salon, nombre_edificio FROM curso'
    
        try:
            self.cursor.execute(sql)
            recorrido = self.cursor.fetchall()
            dic_puntoa = {}
            dic_puntoa['data'] = []

            for i in recorrido:
                dic_puntoa['data'].append ( {
                    "Nombre curso":i[0],
                    "Nombre carrera": i[1],
                    "Nombre": i[2],
                    "Apellido": i[3],
                    "Numero salon": i[4],
                    "Efidicio": i[5]
                } )

        except Exception as e:
            raise
        
        file = open('dic_puntoa.json', 'w')
        json.dump(dic_puntoa, file, indent=4, ensure_ascii=False)

#Obtener la lista de profesores que dictan cursos de la facultad de Humanidades mostrando el nombre completo del profesor y el curso que dicta.

    def puntoB(self):
        sql= 'SELECT nombre_facultad, nombre_carrera, nombre_curso, nombre, apellido FROM facultad INNER JOIN carrera ON facultad.idfacultad= carrera.facultad_idfacultad INNER JOIN curso ON carrera.idcarrera = curso.carrera_idcarrera INNER JOIN profesor ON profesor.id_profesor = curso.profesor_id_profesor INNER JOIN usuarios ON usuarios.id =profesor.usuarios_id1 WHERE nombre_facultad= "Humanidades y Ciencias Sociales"'

        try:
            self.cursor.execute(sql)
            recorrido = self.cursor.fetchall()
            dic_puntob = {}
            dic_puntob['data'] = []

            for i in recorrido:
                dic_puntob['data'].append ( {
                    "Nombre facultad":i[0],
                    "Nombre carrera": i[1],
                    "Nombre curso": i[2],
                    "Nombre": i[3],
                    "Apellido": i[4]
                })

        except Exception as e:
            raise

        file = open('dic_puntob.json', 'w')
        json.dump(dic_puntob, file, indent=4, ensure_ascii=False)


database = Database()
database.puntoA()
database.puntoB()



   