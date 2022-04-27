
#------------------------------- PUNTO A --------------------------------------------

#Listar todos los cursos ofrecidos en la carrera de Ingeniería de Sistemas mostrando la siguiente información: 
#el nombre del curso, el profesor que dicta el curso, en que salón se dictará y a qué hora (tener en cuenta que un 
#mismo curso puede ser dictado por profesores diferentes, en horarios diferentes y en salones diferentes).#

use matricula_javeriana;

SELECT  nombre_curso, nombre_carrera, nombre, apellido, numero_salon, nombre_edificio FROM curso
inner join carrera on idcarrera = carrera_idcarrera
inner join profesor on profesor.id_profesor = curso.profesor_id_profesor
inner join usuarios on usuarios.id = profesor.usuarios_id1
inner join franja_horaria on franja_horaria.curso_idcurso = curso.idcurso
inner join salon on salon.id_salon = franja_horaria.salon_numero_salon
inner join edificio on edificio.id_edificio = salon.edificio_id_edificio
where nombre_carrera = "ingenieria de sistemas";


#------------------------------- PUNTO B --------------------------------------------

#Obtener la lista de profesores que dictan cursos de la facultad de Humanidades mostrando el nombre completo del profesor y el curso que dicta.

SELECT nombre_facultad, nombre_carrera, nombre_curso, nombre, apellido
FROM facultad
INNER JOIN carrera on facultad.idfacultad= carrera.facultad_idfacultad
INNER JOIN curso on carrera.idcarrera = curso.carrera_idcarrera
INNER JOIN profesor on profesor.id_profesor = curso.profesor_id_profesor
INNER JOIN usuarios on usuarios.id =profesor.usuarios_id1
WHERE nombre_facultad=  "Humanidades y Ciencias Sociales";

#------------------------------- PUNTO C --------------------------------------------

#Obtener la lista de profesores que dictan cursos en dos carreras diferentes mostrando el nombre del profesor, el curso que dicta y la carrera a 
#la que pertenece el curso. Pista: averigua cómo funciona la sentencia WITH.

WITH p1 as (
	SELECT   count(distinct nombre_carrera) as conteo, nombre, apellido, GROUP_CONCAT(distinct nombre_curso) as nombre_curso, GROUP_CONCAT(distinct nombre_carrera) as nombre_carrera
	FROM facultad
	INNER JOIN carrera on facultad.idfacultad= carrera.facultad_idfacultad
	INNER JOIN curso on carrera.idcarrera = curso.carrera_idcarrera
	INNER JOIN profesor on profesor.id_profesor = curso.profesor_id_profesor
	INNER JOIN usuarios on usuarios.id =profesor.usuarios_id1
    group by nombre
	order by nombre asc)
select nombre, apellido, nombre_curso, nombre_carrera, conteo as cantidad_carreras  from p1
where conteo =2
group by p1.nombre
order by p1.nombre_carrera;


#------------------------------- PUNTO D --------------------------------------------

#Para un estudiante en particular, obtener el listado de cursos que puede matricular (tener en cuenta que los cursos se dividen en diferentes semestres y
# pertenecen a determinadas carreras, además no se podría matricular un curso ya matriculado). Pista: averigua el uso de la sentencia NOT EXISTS.

SELECT    nombre_curso, semestre_curso FROM    usuarios u
    inner join estudiante e on e.usuarios_id = u.id
    inner join matricula m on m.estudiante_id_estudiante = e.id_estudiante
    inner join matricula_has_curso mhc on mhc.matricula_idmatricula = m.idmatricula
    inner join curso c on c.idcurso = mhc.curso_idcurso
    inner join carrera ca on ca.idcarrera = c.carrera_idcarrera
WHERE not EXISTS (
	select  1  from usuarios
	where correo = 'aliquam.enim@outlook.edu'
	AND semestre_curso  <=8
    ) 
group by nombre_curso;


#------------------------------- PUNTO D --------------------------------------------
#------------------------------- OPCION 2 --------------------------------------------


select  nombre_curso, semestre_curso  from curso
inner join matricula_has_curso on matricula_has_curso.curso_idcurso = curso.idcurso
inner join matricula on matricula.idmatricula = matricula_has_curso.matricula_idmatricula
inner join estudiante on estudiante.id_estudiante = matricula.estudiante_id_estudiante
inner join usuarios on usuarios.id = estudiante.usuarios_id

where correo != 'aliquam.enim@outlook.edu'
AND semestre_curso  >8
group by nombre_curso ;

#------------------------------- PUNTO E --------------------------------------------
#Listar los estudiantes que se han inscrito a un determinado curso mostrando el nombre completo del estudiante y el nombre del curso.

SELECT nombre_curso, nombre, apellido, correo from curso
inner join matricula_has_curso on matricula_has_curso.curso_idcurso = curso.idcurso
inner join matricula on matricula.idmatricula = matricula_has_curso.matricula_idmatricula
inner join estudiante on estudiante.id_estudiante = matricula.estudiante_id_estudiante
inner join usuarios on usuarios.id = estudiante.usuarios_id;


