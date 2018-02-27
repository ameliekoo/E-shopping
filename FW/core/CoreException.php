<?php
/**
 * ------------------------------------------------------------
 * CORE EXCEPTION
 * ------------------------------------------------------------
**/
class CoreException extends Exception {
    /**
     * --------------------------------------------------
     * METHODS
     * --------------------------------------------------
    **/
    /**
     * __toString - Determines how the object responds when treated as a string
     * @param
     * @return
    **/
    public function __toString() {

        return 'An error occured with code <strong>' . $this->getCode() . '</strong> in <strong>' . $this->getFile() . '</strong> at line <strong>' . $this->getLine() . '</strong><br />The following information has been provided :<br />' . $this->getMessage() . '<hr />' . $this->getTraceAsString();
    }
}
