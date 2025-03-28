<?php

declare(strict_types=1);

namespace App\Twig\Component\Swiper;

use Sulu\Component\SmartContent\ArrayAccessItem;
use Symfony\UX\TwigComponent\Attribute\AsTwigComponent;

#[AsTwigComponent('swiper', template: 'component/swiper/swiper.html.twig')]
class SwiperComponent
{
    /**
     * @var ArrayAccessItem[]
     */
    public array $blogPosts;

}