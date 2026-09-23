# ANSIBLE ET LES EQUIPEMENTS RESEAU (SWITCH & ROUTEUR CISCO)


**Objectif :** Ce projet a pour but d'automatiser les configurations sur des équipements en utilisant l'outil Ansible. 



### I- PREREQUIS
Afin de reproductuire ce travail, il est important que vous ayez les éléments suivants sur votre os (Ubuntu Desktop/dans mon cas):
- Eveng : ici nous allons ajouter des nodes pour la machine ubuntu (sur laquelle nous allons installer ansible et ansible-pylibssh), pour nos switchs (tous étant du même modèle) et nos routeurs (tous étant aussi du même modèle). 

**NB :** Dans un contexte réel, nous aurons juste de besoin d'une machine sur laquelle ansible est installé et des équipements physique au lieu d'utiliser *Eveng*.

### II- ANSIBLE POUR LE RESEAU

<p align="left">
  <img src="./images/ansible_network.png" width="85%" caption="Texte">
</p>


#### A. Préparation 
##### a) Préparation du serveur ansible

##### b) Préparation des équipements réseau
Cette étape fait référence à la configuration de base à effectuer sur nos équipements réseau. Elle est importante car elle permettra à ansible par la suite de pouvoir se connecter à nos équipements par ssh. Il s'agit notamment de :
1. Configurer les interfaces : Nous allons configurer l'interface vlan 1 sur l'ensemble de nos switchs et une interface sur l'ensemble de nos routeurs. Nous devrions veuillez à ce que les adresses IP de ces interfaces soit dans le même réseau que notre serveur qui héberge **ansible**
2. Configurer le ssh et l'utilisateur qui s'y connectera : nous allons donc configurer l'utilisateur et le protocole ssh, la version du protocole ssh ;
3. Configurer l'accès en mode privilégié via le mot de passe ;
4. Configurer le chiffrement des mots de passe : nous allons configurer l'accès au mode enable en utilisant un mot de passe;
5. configurer l'interface VTY.

L'exmeple suivant présente ces configurations pour l'interface vlan 1 du SWICH 1. Il impotant de s'assurer que si l'ip du serveur ansible est par exemple (ip 192.168.80.1/24), alors les ip des autres équipements devront être dans la même plage avec le même masque. 

Pour nos équipements reseau, nous allons choisir la plage 192.168.80.10-192.168.80.17/24. Ainis dans notre cas nous avons 6 switchs et 02 routeurs. Donc l'ip des interfaces **vlan 1** de nos switchs iront de **192.168.80.10-192.168.80.15/24** et les 02 interfaces (**Ethernet0/0**) de nos routeurs iront de **192.168.80.16-192.168.80.17/24**. Ci-dessous nous avons une configuration initaile sur un de nos switchs, nous allons faire la même chose sur les autres équipements.
```shell
# -+ Configuration de l'IP de l'interface vlan 1 ou juste une interface Ethernet0/1:
  Switch> en 
  Switch# configure terminal
  Switch(config)# interface vlan 1
  Switch(config-if)# ip address 192.168.80.10 255.255.255.0
  Switch(config-if)# no shutdown
  Switch(config-if)# exit 
# -+ Configuration du domaine : 
  Switch(config)# ip domain name manageme.org
# -+ Configuration du SSH : 
  Switch(config)# crypto key generate rsa general-keys modulus 2048
  Switch(config)# ip ssh version 2
# -+ Configuration des ligne vty :
  Switch(config)# line vty 0 4
  Switch(config-line)# transport input ssh 
  Switch(config-line)# login local
  Switch(config-line)# exit
# -+ Création de l'utilisateur qui devra se connecter en SSH :
  Switch(config)# username cisco password cisco 
# -+ Activation du chiffrement du mot de passe :
  Switch(config)# service password-encryption
# -+ Configuration du mot de passe pour le mode privilégié :
  Switch(config)# enable secret cisco
  Switch(config)# end
```
Une fois la configuration terminée sur l'ensemble de nos équipements, nous allons exécuter le ping depuis l'un de ces équipements vers l'ensemble des autres pour s'assurer que tout est *okey*.

**NB :** Les informations de connexions seront les mêmes sur tous nos équipements (mot de passe enable, username/password pour la connexion SSH).

#### 2. Exécution des playbook
La configuration primordiale étant exécutée, nous allons passer à quelque chose d'un peu plus costaud. 
```shell
# -
```