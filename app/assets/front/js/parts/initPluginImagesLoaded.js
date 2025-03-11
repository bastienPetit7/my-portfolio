import { $, $doc } from './_utility.js';

function initPluginImagesLoaded() {
    $doc.imagesLoaded().done( () => {
        $doc.trigger( 'images.loaded' );
    } );
}

export { initPluginImagesLoaded };
