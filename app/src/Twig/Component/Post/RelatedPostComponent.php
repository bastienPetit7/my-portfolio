<?php

declare(strict_types=1);

namespace App\Twig\Component\Post;

use Sulu\Component\SmartContent\ArrayAccessItem;
use Symfony\UX\TwigComponent\Attribute\AsTwigComponent;

#[AsTwigComponent('related_post', template: 'component/post/related_post.html.twig')]
class RelatedPostComponent
{
    /**
     * @var ArrayAccessItem[]
     */
    public array $pages;
}
