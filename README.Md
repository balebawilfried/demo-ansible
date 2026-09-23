# ANSIBLE ET LES EQUIPEMENTS RESEAU (SWITCH & ROUTEUR CISCO)


**Objectif :** Ce projet a pour but d'automatiser les configurations sur des équipements réseau (switch et routeur cisco), système. 



### I- PREREQUIS
Afin de reproductuire ce travail, il est important que vous ayez les éléments suivants sur votre os (Ubuntu Desktop/dans mon cas):
- Eveng (Dans la mesure où vous voulez faire de la virtualisation mais vous pourez appliquer les même configuration sur vos équipements physique);
- ansible-pylibssh 

<p align="left">
  <img src="../routeur_switch_cisco/images/eveng.png" width="45%">
</p>

### III- ANSIBLE POUR LE RESEAU

#### 1. Préparation 
Cette étape fait référence à la configuration de base à effectuer sur nos équipements réseau. Elle est importante car elle permettra à ansible par la suite pouvoir se connecter à nous équipements. Il s'agit notamment de :
- Configurer les interfaces : Nous allons configurer l'interface vlan 1 sur l'ensemble de nos switchs et une interface sur l'ensemble de nos routeurs. Nous devrions veuillez à ce que les adresses IP de ces interfaces soit dans le même réseau que notre serveur qui héberge **ansible**
- configurer le ssh et l'utilisateur qui s'y connectera : nous allons donc configurer l'utilisateur et le protocole ssh, la version du protocole
