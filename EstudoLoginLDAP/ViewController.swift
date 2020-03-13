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
    let transiton = SlideInTransition()
    var topView: UIView?
    var disparaSegue: Bool = false

    // MARK: - Ciclo de vida da view
    override func viewDidLoad()
    {
        super.viewDidLoad()

        InicializaViewLogin()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        statusLabel.text = networkCheck.currentStatus == .satisfied ? "Connected" : "Disconnected"
        networkCheck.addObserver(observer: self)
        
//        mostra onde fica o BD SQLite
//        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let  docsDir = dirPaths[0]
//        print(docsDir)
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        networkCheck.removeObserver(observer: self)
    }
    
    fileprivate func InicializaViewLogin()
    {
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
        
        //deletaUsuario()
        //buscaUsuario()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        return disparaSegue
    }
    // MARK: - Acaos dos botoes
    @IBAction func loginAcao(_ sender: Any)
    {
        if validaEntrada()
        {
            salvaUsuario()
            disparaSegue = true
        }
        else
        {
            disparaSegue = false
        }
    }
    
//    @IBAction func btnAjuda(_ sender: Any)
//    {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let TelaAjudaVC = storyBoard.instantiateViewController(identifier: "TelaAjudaVC") as! AjudaVC
//        self.present(TelaAjudaVC, animated: true, completion: nil)
//    }

    @IBAction func didTapMenu(_ sender: UIBarButtonItem)
    {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as? SideMenuTVC
        else
        { return }
        
        menuViewController.didTapMenuType = { menuType in self.transitionToNew(menuType)}
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    // MARK: - UITextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
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
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
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
        let usuarioValido = Login()
        
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
        
        if usuarioValido.validaUsuario(login: txtUsuario.text!, senha: txtSenha.text!) == false
        {
            retorno = false
            displayErrorMessage(title: "Aviso", message: "Usuário ou senha inválido")
        }
        return retorno
    }
    
    // MARK: - SideMenu
    func transitionToNew(_ menuType: MenuType)
    {
        let title = String(describing: menuType).capitalized
        self.title = title

        topView?.removeFromSuperview()
        switch menuType
        {
            case .perfil:
                guard let viewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PerfilVC") as? PerfilVC
                    else {return}
                    navigationController?.pushViewController(viewVC, animated: true)
            
            case .logout:
                let login = Login()
                login.atualizaStatusLogin(status: "nao")
                
            case .ajuda:
                guard let viewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AjudaVC") as? AjudaVC
                    else {return}
                    navigationController?.pushViewController(viewVC, animated: true)

            default:
                break
        }
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
                self.usuario.forEach({print($0.nome!)})
            }
        }
        catch
        {
            // verificacao de erros aqui
            print("Ocorreu um erro de core data")
        }
    }
    
    private func deletaUsuario()
     {
        let usuario = Usuario(context: PersistenceService.context)
        PersistenceService.context.delete(usuario) // .fetch(fetchRequest)
        print("Usuário excluído")
    }
}

// MARK: - Extensoes
extension ViewController: UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        transiton.isPresenting = false
        return transiton
    }
}

