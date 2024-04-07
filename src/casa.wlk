object casaDePepeYJulian {

	var montoParaReparaciones = 0 // en pesos
	var viveresActuales = 50 // porcentual
	var cuentaBancaria = cuentaCte
	var estrategiaDeAhorro = minimo
	const viveresMinimos = 40

	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	method cuentaBancaria(_cuentaBancaria) {
		cuentaBancaria = _cuentaBancaria
	}

	method montoParaReparaciones(_montoParaReparaciones) {
		montoParaReparaciones = _montoParaReparaciones
	}

	method montoParaReparaciones() {
		return montoParaReparaciones
	}

	method viveresActuales(_viveresActuales) {
		viveresActuales = _viveresActuales
	}

	method viveresActuales() {
		return viveresActuales
	}

	method hayViveresSuficientes() {
		return viveresActuales > viveresMinimos
	}

	method hayQueHacerReparaciones() {
		return montoParaReparaciones > 0
	}

	method estaEnOrden() {
		return self.hayViveresSuficientes() && not self.hayQueHacerReparaciones()
	}

	method saldoEnCuenta() {
		return cuentaBancaria.saldo()
	}

	method depositarEnCuenta(monto) {
		cuentaBancaria.depositar(monto)
	}

	method hacerMantenimiento() {
		estrategiaDeAhorro.aplicarEn(self)
	}

	method hacerReparaciones() {
		cuentaBancaria.extraer(montoParaReparaciones)
		montoParaReparaciones = 0
	}

	method montoParaViveres(viveresAComprar) {
		return viveresAComprar * estrategiaDeAhorro.calidad()
	}

	method comprarViveres(viveresAComprar) {
		cuentaBancaria.extraer(self.montoParaViveres(viveresAComprar))
		viveresActuales += viveresAComprar
	}

	method generarGasto(monto) {
		cuentaBancaria.extraer(monto)
	}

	method hacerReparacionesSiSobraSaldo(sobraSaldo) {
		if (sobraSaldo) {
			self.hacerReparaciones()
		}
	}

}

//CUENTAS
object cuentaCte {

	var saldo = 0

	method saldo() {
		return saldo
	}

	method saldo(_saldo) {
		saldo = _saldo
	}

	method depositar(monto) {
		saldo = monto
	}

	method extraer(monto) {
		saldo -= monto
	}

}

object cuentaConGastos {

	var saldo = 0
	var costoOperacion = 20

	method costoOperacion(_costoOperacion) {
		costoOperacion = _costoOperacion
	}

	method saldo() {
		return saldo
	}

	method depositar(monto) {
		saldo = monto - costoOperacion
	}

	method extraer(monto) {
		saldo -= monto
	}

}

object cuentaCombinada {

	var primaria = cuentaConGastos
	var secundaria = cuentaCte

	method primaria(_primaria) {
		primaria = _primaria
	}

	method secundaria(_secundaria) {
		secundaria = _secundaria
	}

	method depositar(monto) {
		primaria.depositar(monto)
	}

	// Preguntar
	method extraer(monto) {
		if (self.haySaldoSuficiente(monto)) primaria.extraer(monto) else secundaria.extraer(monto)
	}

	method haySaldoSuficiente(monto) {
		return monto <= primaria.saldo()
	}

	method saldo() {
		return primaria.saldo() + secundaria.saldo()
	}

}

//Estrategias de ahorro
object minimo {

	const property calidad = 2
	const property viveresMinimosNecesarios = 40

	method aplicarEn(casa) {
		if (not casa.hayViveresSuficientes()) {
			casa.comprarViveres(self.calcularViveresAComprar(casa))
		}
	}

	method calcularViveresAComprar(casa) {
		return viveresMinimosNecesarios - casa.viveresActuales()
	}

}

object full {

	const property calidad = 5
	const porcentajeDeAumento = 40

	method aplicarEn(casa) {
		if (casa.estaEnOrden()) {
			casa.comprarViveres(self.calcularViveresAComprar(casa))
		} else {
			// Aumenta un 40%. Como maximo
			casa.comprarViveres(porcentajeDeAumento)
		}
		casa.hacerReparacionesSiSobraSaldo(self.sobraSaldo(casa))
	}
	
	method sobraSaldo(casa) {
		return casa.saldoEnCuenta() - casa.montoParaReparaciones() > 1000
	}

	method calcularViveresAComprar(casa) {
		return 100 - casa.viveresActuales()
	}

}

/*
 * Para pensar: Si se agrega una nueva casa, ¿Es posible usar estas estrategias con ella? 
 * ¿Qué mensajes debería entender? (Podés responder con comentarios en el código o directamente inventando 
 * otra casa con tu propia implementación para que funcione)
 * 
 * RESPUESTAS: 
 * Si se pueden usar las estrategias, pero tiene que entender todos los mensajes que la casa de pepe y julian.
 */
object casaDeJoseYMaria {

	var montoParaReparaciones = 0 // en pesos
	var viveresActuales = 50 // porcentual
	var cuentaBancaria = cuentaCte
	var estrategiaDeAhorro = minimo
	const viveresMinimos = 40

	method estrategiaDeAhorro(_estrategiaDeAhorro) {
		estrategiaDeAhorro = _estrategiaDeAhorro
	}

	method cuentaBancaria(_cuentaBancaria) {
		cuentaBancaria = _cuentaBancaria
	}

	method montoParaReparaciones(_montoParaReparaciones) {
		montoParaReparaciones = _montoParaReparaciones
	}

	method montoParaReparaciones() {
		return montoParaReparaciones
	}

	method viveresActuales(_viveresActuales) {
		viveresActuales = _viveresActuales
	}

	method viveresActuales() {
		return viveresActuales
	}

	method hayViveresSuficientes() {
		return viveresActuales > viveresMinimos
	}

	method hayQueHacerReparaciones() {
		return montoParaReparaciones > 0
	}

	method estaEnOrden() {
		return self.hayViveresSuficientes() && not self.hayQueHacerReparaciones()
	}

	method saldoEnCuenta() {
		return cuentaBancaria.saldo()
	}

	method depositarEnCuenta(monto) {
		cuentaBancaria.depositar(monto)
	}

	method hacerMantenimiento() {
		estrategiaDeAhorro.aplicarEn(self)
	}

	method hacerReparaciones() {
		cuentaBancaria.extraer(montoParaReparaciones)
		montoParaReparaciones = 0
	}

	method montoParaViveres(viveresAComprar) {
		return viveresAComprar * estrategiaDeAhorro.calidad()
	}

	method comprarViveres(viveresAComprar) {
		cuentaBancaria.extraer(self.montoParaViveres(viveresAComprar))
		viveresActuales += viveresAComprar
	}

	method generarGasto(monto) {
		cuentaBancaria.extraer(monto)
	}

	method hacerReparacionesSiSobraSaldo(sobraSaldo) {
		if (sobraSaldo) {
			self.hacerReparaciones()
		}
	}
}

