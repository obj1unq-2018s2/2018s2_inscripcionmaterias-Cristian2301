import materias.*
import carreras.*

class Estudiante {
	var property materiasAprobadas
	var property carrerasQueCursa
	var property cantCreditos
	
	method puedeCursar(materia){
		return self.correspondeAUnaCarreraQueCursa(materia) and not self.aproboLaMateriaAntes(materia) and 
		not self.estaInscripto(materia) and materia.prerrequisitos(self)
	}
	
	method correspondeAUnaCarreraQueCursa(materia){
		return carrerasQueCursa.any({carrera => carrera.materias().contains(materia)})
	}
	
	method aproboLaMateriaAntes(materia){
		return materiasAprobadas.any({materiaAprobada => materiaAprobada.materia() == materia})
	}
	
	method estaInscripto(materia){
		// TODO Mejor con contains
		return materia.estudiantesInscriptos().any({estudiante => estudiante == self})
	}
	
	method aprobo(laMateria, laNota){
		 materiasAprobadas.add(new MateriaAprobada(materia = laMateria, nota = laNota))                       
	}
	
	method materiasQueSePuedeInscribirDe(carrera){
			return carrera.materias().filter({materia => self.puedeCursar(materia)})
	}
	
	method materiasQueEstaInscripto(){
		// TODO Falta más delegación y subtareas
		return carrerasQueCursa.map({carrera => carrera.materias().filter({materia => materia.estudiantesInscriptos().contains(self)})
		}).flatten().asSet()
	}
	
	method materiasQueQuedoEnListaDeEspera(){
		// TODO Falta más delegación y subtareas
		return carrerasQueCursa.map({carrera => carrera.materias().filter({materia => materia.estudiantesEsperando().contains(self)})
		}).flatten().asSet()
	}

}


