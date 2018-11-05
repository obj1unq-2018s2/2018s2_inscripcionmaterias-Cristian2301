class MateriaAprobada{
	var property materia 
	var property nota 
}


class Materia {
	var estudiantesInscriptos
	var carrera
	var property cupo
	var estudiantesEsperando
	
	method inscribir(estudiante){
		if(estudiante.puedeCursar(self) and cupo > estudiantesInscriptos.size()){
			estudiantesInscriptos.add(estudiante)
			cupo -= 1
		}
		else if(cupo <= estudiantesInscriptos.size()){
			estudiantesEsperando.add(estudiante)
		}
	}
	
	method darDeBaja(estudiante){
		estudiantesInscriptos.remove(estudiante)
		if(not estudiantesEsperando.isEmpty()){
			estudiantesInscriptos.add(estudiantesEsperando.first())
		}
	}
	
	method estudiantesInscriptos(){
		return estudiantesInscriptos
	}
	
	method estudiantesEsperando(){
		return estudiantesEsperando
	}
}




class MateriaQueTieneCorrelativas inherits Materia {
	var materiasCorrelativas

	// TODO Este nombre es muy poco claro.	
	method prerrequisitos(estudiante){
		// TODO Delegar en estudiante y código repetido.
		return materiasCorrelativas.all({materia => estudiante.materiasAprobadas().contains(materia)})
	}
	
}



class MateriaQueNecesitaCreditos inherits Materia {
	var property cantCreditosRequeridos
	var cantCreditosOtorga // TODO Este atributo corresponde a la superclase, y no se está usando
	
	method prerrequisitos(estudiante){
		return estudiante.cantCreditos() >= cantCreditosRequeridos
	}
}



class MateriaQueHayQueTenerMateriasAprobadas inherits Materia {
	var property anioAlCualPertenece // TODO Este atributo corresponde a la superclase
	
	method prerrequisitos(estudiante){
		// TODO Delegar en estudiante, no le pidas su colección de materias, preguntale si aprobó.
		return self.materiasDelAnioPasado().all({materia => estudiante.materiasAprobadas().contains(materia)})
	}
	
	method materiasDelAnioPasado(){
		return carrera.materias().filter({materia => materia.anioAlCualPertenece() == anioAlCualPertenece - 1})
	}
}
