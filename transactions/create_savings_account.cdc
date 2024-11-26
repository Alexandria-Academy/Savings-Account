import "FlowToken"

// This is a single transaction that creates a FlowToken Vault inside your account
// to use for saving Flow tokens

transaction {

	prepare(Cuenta: auth(Capabilities, Storage) &Account) {

        // Create a path for your savings account
        let ahorro_Privado = StoragePath(identifier: "Cuenta_de_Ahorro")!
        // Create a FlowToken Vault
        let vault <- FlowToken.createEmptyVault(vaultType: Type<@FlowToken.Vault>())
        // Save the new path into your account
        Cuenta.storage.save(<- vault , to: ahorro_Privado)


        // Create a public capability to the Vault that only exposes
        // the deposit function through the Receiver interface
        let vaultCap = Cuenta.capabilities.storage.issue<&FlowToken.Vault>(ahorro_Privado)
        let ahorro_Publico = PublicPath(identifier: "Cuenta_de_Ahorro")!
        Cuenta.capabilities.publish(vaultCap, at: ahorro_Publico)
		
	}

}