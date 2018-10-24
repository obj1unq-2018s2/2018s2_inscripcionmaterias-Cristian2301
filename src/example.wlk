class MateriaAprobada{
	var property materia 
	var property nota 
}

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
		return materia.estudiantesInscriptos().any({estudiante => estudiante == self})
	}
	
	method aprobo(laMateria, laNota){
		 materiasAprobadas.add(new MateriaAprobada(materia = laMateria, nota = laNota))                       
	}

}







class Materia {
	var property estudiantesInscriptos // cambiar los metodooss
	var carrera
	var curso
	var cupo
	var property estudiantesEsperando
	
	method inscribir(estudiante){
		if(estudiante.puedeCursar(self) and cupo > 0){
			estudiantesInscriptos.add(estudiante)
		}
		else{
			estudiantesEsperando.add(estudiante)
		}
	}
	
	method darDeBaja(estudiante){
		estudiantesInscriptos.remove(estudiante)
		if(not estudiantesEsperando.isEmpty()){
			estudiantesEsperando.first().materiasInscripto().add(self)  //// cambiaarrrr!!!
		}
	}
	
	method estudiantesInscriptos(){
		
	}
	
	method estudiantesEnEspera(){
		return self.estudiantesEsperando()
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




class Carrera {
	var property materias 
}
