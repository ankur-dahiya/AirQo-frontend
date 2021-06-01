<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInita4a15006903238dab15748beb204647c
{
    public static $prefixLengthsPsr4 = array (
        'S' => 
        array (
            'Symfony\\Component\\Dotenv\\' => 25,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Symfony\\Component\\Dotenv\\' => 
        array (
            0 => __DIR__ . '/..' . '/symfony/dotenv',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInita4a15006903238dab15748beb204647c::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInita4a15006903238dab15748beb204647c::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
