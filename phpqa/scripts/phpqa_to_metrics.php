<?php
$path = 'test/phpqa/';

// process PHPCS metrics
if ($xml = load_xml_file($path . 'checkstyle.xml')) {
    echo "# TYPE PHPCS metrics" . PHP_EOL;
    $errors = $xml->xpath('//checkstyle/file/error[@severity="error"]');
    echo "phpcs.errors " . count($errors) . PHP_EOL;
    $warnings = $xml->xpath('//checkstyle/file/error[@severity="warning"]');
    echo "phpcs.warnings " . count($warnings) . PHP_EOL;
}

// process PDepend metrics
if ($xml = load_xml_file($path . 'pdepend-summary.xml')) {
    echo "# TYPE PDepend metrics" . PHP_EOL;
    $excluded_attributes = ['pdepend', 'generated'];
    foreach ($xml->attributes() as $attribute => $value) {
        if (!in_array($attribute, $excluded_attributes)) {
            echo 'pdepend.' . $attribute . ' ' . $value . PHP_EOL;
        }
    }
}

// process php_cs_fixer metrics
if ($xml = load_xml_file($path . 'php-cs-fixer.xml')) {
    echo "# TYPE php_cs_fixer metrics" . PHP_EOL;
    $excluded_attributes = ['time', 'name'];
    foreach ($xml->xpath('//testsuites/testsuite')[0]->attributes() as $attribute => $value) {
        if (!in_array($attribute, $excluded_attributes)) {
            echo 'php-cs-fixer.' . $attribute . ' ' . $value . PHP_EOL;
        }
    }
}

// process PHPCPD metrics
if ($xml = load_xml_file($path . 'phpcpd.xml')) {
    echo "# TYPE PHPCPD metrics" . PHP_EOL;
    $errors = $xml->xpath('//pmd-cpd/duplication');
    echo "phpcpd.duplications " . count($errors) . PHP_EOL;
}

// process phploc metrics
if ($xml = load_xml_file($path . 'phploc.xml')) {
    echo "# TYPE phploc metrics" . PHP_EOL;
    foreach ($xml->xpath('//phploc')[0] as $attribute => $value) {
        echo 'phploc.' . $attribute . ' ' . $value . PHP_EOL;
    }
}

// process phpmnd metrics
if ($xml = load_xml_file($path . 'phpmnd.xml')) {
    echo "# TYPE phpmnd metrics" . PHP_EOL;
    $excluded_attributes = ['version', 'fileCount'];
    foreach ($xml->attributes() as $attribute => $value) {
        if (!in_array($attribute, $excluded_attributes)) {
            echo 'phpmnd.' . $attribute . ' ' . $value . PHP_EOL;
        }
    }
}

// process phpmd metrics
if ($xml = load_xml_file($path . 'phpmd.xml')) {
    echo "# TYPE phpmd metrics" . PHP_EOL;
    foreach (range(1, 4) as $priority) {
        $errors = $xml->xpath('//pmd/file/violation[@priority=' . $priority . ']');
        echo "phpmd.violation.priority.$priority " . count($errors) . PHP_EOL;
    }
    $errors = $xml->xpath('//pmd/error');
    echo "phpmd.errors " . count($errors) . PHP_EOL;
}

// process phpstan metrics
if ($xml = load_xml_file($path . 'phpstan.xml')) {
    echo "# TYPE phpstan metrics" . PHP_EOL;
    $errors = $xml->xpath('//checkstyle/file/error');
    echo "phpstan.errors " . count($errors) . PHP_EOL;
}

// process psalm metrics
if ($xml = load_xml_file($path . 'psalm.xml')) {
    echo "# TYPE psalm metrics" . PHP_EOL;
    $errors = $xml->xpath('//report/item/severity[.="info"]');
    echo "psalm.info " . count($errors) . PHP_EOL;
    $errors = $xml->xpath('//report/item/severity[.="error"]');
    echo "psalm.error " . count($errors) . PHP_EOL;
}

function load_xml_file($file)
{
    if (file_exists($file) && filesize($file) > 0) {
        $xml = simplexml_load_file($file);
        if ($xml instanceof SimpleXMLElement) {
            return $xml;
        }
    }
    return false;
}
