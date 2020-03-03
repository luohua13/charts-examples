-- Create tsf_tx schema
DROP SCHEMA IF EXISTS `tsf_tx`;
CREATE SCHEMA `tsf_tx` ;

-- Create Account
DROP USER IF EXISTS `tsf_tx`;
CREATE USER `tsf_tx`@'%' IDENTIFIED BY 'Tcdn@2007';
GRANT ALL PRIVILEGES ON tsf_tx.* TO 'tsf_tx'@'%' IDENTIFIED BY 'Tcdn@2007';
FLUSH PRIVILEGES;
