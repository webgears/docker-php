<?php
namespace Tests\PHPQAExtensions;

use Edge\QA\OutputMode;
use MacFJA\PHPQAExtensions\ToolDefinition;

/**
 * PHPQA tool mapping for PHPUnit coverage results
 *
 * @author  MacFJA
 * @license MIT
 */
class PHPUnitCoverage extends \Edge\QA\Tools\Tool implements ToolDefinition
{
    public static $SETTINGS = array(
        'optionSeparator' => '=',
        'composer' => 'phpunit/phpunit',
        'internalClass' => ['PHPUnit_Framework_TestCase', 'PHPUnit\Framework\TestCase'],
    );

    /**
     * Get composer vendor/package name
     *
     * @return string
     */
    public static function getComposer()
    {
        return static::$SETTINGS['composer'];
    }

    /**
     * Get tool name
     *
     * @return string
     */
    public static function getToolName()
    {
        return 'PHPUnit coverage results';
    }

    /**
     * Get tool report xsl filename (or {@code null} for cli)
     *
     * @return string|null
     */
    public static function getReportName()
    {
        return dirname(__DIR__,2).'/report/phpunit.xsl';
    }

    /**
     * Get tool cli name
     *
     * @return string
     */
    public static function getCliName()
    {
        return 'phpunit-coverage';
    }

    /**
     * Get the FQCN of the tool
     * (use to check if the tool exist trough the autoloader)
     *
     * @return string
     */
    public static function getInternalClass()
    {
        return static::$SETTINGS['internalClass'];
    }

    public function __invoke()
    {
        $this->tool->htmlReport = $this->options->rawFile('coverage/dashboard.html');
        return [];
    }
}
