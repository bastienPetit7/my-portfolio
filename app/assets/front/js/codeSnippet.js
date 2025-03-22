import hljs from 'highlight.js';
import 'highlight.js/styles/monokai.min.css';

 const snippets= document.querySelectorAll('.code');
 snippets.forEach(snippet => {
   hljs.highlightElement(snippet);
 });

console.log('is_on');