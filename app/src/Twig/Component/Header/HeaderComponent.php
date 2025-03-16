<?php

declare(strict_types=1);

namespace App\Twig\Component\Header;

use Symfony\UX\TwigComponent\Attribute\AsTwigComponent;

#[AsTwigComponent('header', 'component/header/header.html.twig')]
class HeaderComponent
{
    /**
     * @var array<string, string[]>
     */
    public array $localizations;
}
