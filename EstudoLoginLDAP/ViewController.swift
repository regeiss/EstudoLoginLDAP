//
//  ViewController.swift
//  EstudoLoginLDAP
//
//  Created by Roberto Edgar Geiss on 03/12/19.
//  Copyright © 2019 Roberto Edgar Geiss. All rights reserved.
//
import Foundation
import UIKit
import Network
import CoreData
 
class ViewController: UIViewController, UITextFieldDelegate, NetworkCheckObserver
{
    // MARK: - Campos da tela
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Variaveis
    var networkCheck = NetworkCheck.sharedInstance()
    var container: NSPersistentContainer!
    var usuario = [Usuario]()
    
    // MARK: - Ciclo de vida da view
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Notificacao para mover o teclado.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        // Ajustes dos delegates
        txtUsuario.delegate = self
        txtSenha.delegate = self
        
        // Ajustes do botao
        btnLogin.layer.cornerRadius = 10
        btnLogin.clipsToBounds = true
        btnLogin.backgroundColor = UIColor.systemGray
        btnLogin.titleLabel?.textColor =  UIColor.systemYellow
        
        // Comportamento dos campos
        txtUsuario.borderStyle = .roundedRect
        txtUsuario.backgroundColor = UIColor.systemGray6
        txtSenha.borderStyle = .roundedRect
        txtSenha.backgroundColor = UIColor.systemGray6
        txtUsuario.returnKeyType = .next
        
        buscaUsuario()
//         Monta menu lateral
//        let mainVC = UIViewController()
//        //mainVC.view.backgroundColor = .red
//
//        let rootController = RootViewController(mainViewController: mainVC, topNavigationLeftImage: UIImage(named: "hamburger-menu-icon"))
//        let menuVC = MenuViewController()
//        menuVC.view.backgroundColor = .green
//
//        let drawerVC = DrawerController(rootViewController: rootController, menuController: menuVC)
//        self.addChild(drawerVC)
//        view.addSubview(drawerVC.view)
//        drawerVC.didMove(toParent: self)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        statusLabel.text = networkCheck.currentStatus == .satisfied ? "Connected" : "Disconnected"
        networkCheck.addObserver(observer: self)
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        networkCheck.removeObserver(observer: self)
    }
    
    // MARK: - Acao do botao Login
    @IBAction func loginAcao(_ sender: Any)
    {

        if validaEntrada()
        {
            salvaUsuario()
            self.performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    @IBAction func btnAjuda(_ sender: Any)
    {
        displayErrorMessage(title: "Ajuda", message: "Ajuda da aplicação")
    }
    
    // UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        print("TextField did end editing method called\(textField.text!)")
        switch textField
        {
            case txtUsuario:
                txtUsuario.resignFirstResponder()
                txtSenha.becomeFirstResponder()
            case txtSenha:
                txtSenha.resignFirstResponder()
            default:
                break
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        print("TextField should end editing method called")
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        print("While entering the characters this method gets called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print("TextField should return method called")
        switch textField
        {
            case txtUsuario:
                txtUsuario.resignFirstResponder()
                txtSenha.becomeFirstResponder()
            case txtSenha:
                txtSenha.resignFirstResponder()
            default:
                break
        }
        return true;
    }
    
    // MARK: - Move a tela para mostrar o teclado
    @objc func keyboardWillShow(sender: NSNotification)
    {
         self.view.frame.origin.y = -150
    }

    @objc func keyboardWillHide(sender: NSNotification)
    {
         self.view.frame.origin.y = 0
    }
    
    func displayErrorMessage(title: String, message:String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }

    // MARK: - Mantem status da conexao
    func statusDidChange(status: NWPath.Status)
    {
        statusLabel.text = status == .satisfied ? "Conectado" : "Desconectado"
    }
    
    // MARK: - Valida entrada de dados
    func validaEntrada() -> Bool
    {
        var retorno: Bool = true
        
        if txtUsuario.text!.isEmpty
        {
            displayErrorMessage(title: "Aviso", message: "Usuário deve ser informado")
            retorno = false
        }
        else if txtSenha.text!.isEmpty
        {
            displayErrorMessage(title: "Aviso", message: "Senha deve ser informada")
            retorno = false
        }
        return retorno
    }
    
    // MARK: - Funcoes do coredata
    private func salvaUsuario()
    {
        let usuario = Usuario(context: PersistenceService.context)
        usuario.nome = txtUsuario.text
        usuario.senha = txtSenha.text
        usuario.logado = true
        usuario.dataUltimoLogin = Date()
        usuario.email = "teste@teste.com.br"
        PersistenceService.saveContext()
        print("Objeto salvo")
    }
    
    private func buscaUsuario()
    {
        let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
        do
        {
            let formatoData = DateFormatter()
            formatoData.dateStyle = .full
            
            let usuario = try PersistenceService.context.fetch(fetchRequest)
            self.usuario = usuario
            if self.usuario.count > 0
            {
                for elemento in self.usuario
                {
                    print(elemento.nome! + " " + elemento.senha! + " " + elemento.email!)
                }
            }
        }
        catch
        {
            // verificacao de erros aqui
            print("Ocorreu um erro de core data")
        }
    }
}
