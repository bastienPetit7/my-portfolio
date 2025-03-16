<?php

declare(strict_types=1);

namespace App\Twig\Component\Navigation;

use Symfony\UX\TwigComponent\Attribute\AsTwigComponent;

#[AsTwigComponent('navbar', 'component/navigation/navbar.html.twig')]
class NavbarComponent
{
    /**
     * @var array<string, string[]>
     */
    public array $localizations;
}
