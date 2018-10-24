class MateriaAprobada{
	var property materia 
	var property nota 
}


class Materia {
	var estudiantesInscriptos
	var carrera
	var cupo
	var estudiantesEsperando
	
	method inscribir(estudiante){
		if(estudiante.puedeCursar(self) and cupo > estudiantesInscriptos.size()){
			estudiantesInscriptos.add(estudiante)
		}
		else{
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
	
	method prerrequisitos(estudiante){
		return materiasCorrelativas.all({materia => estudiante.materiasAprobadas().contains(materia)})
	}
	
}



class MateriaQueNecesitaCreditos inherits Materia {
	var property cantCreditosRequeridos
	var cantCreditosOtorga
	
	method prerrequisitos(estudiante){
		return estudiante.cantCreditos() >= cantCreditosRequeridos
	}
}



class MateriaQueHayQueTenerMateriasAprobadas inherits Materia {
	var property anioAlCualPertenece
	
	method prerrequisitos(estudiante){
		return self.materiasDelAnioPasado().all({materia => estudiante.materiasAprobadas().contains(materia)})
	}
	
	method materiasDelAnioPasado(){
		return carrera.materias().filter({materia => materia.anioAlCualPertenece() == anioAlCualPertenece - 1})
	}
}
