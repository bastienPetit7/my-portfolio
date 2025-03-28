
export default class FiltersController {

    constructor() {
        this.filters = document.querySelectorAll('.filter');
        this.posts = document.querySelectorAll('.post');

        this.init();
    }
    init() {

        this.filters.forEach((el) =>{
            let category = el.dataset.filter;
            console.log(category);
            el.addEventListener('click', () =>{
                this.exposeCategory(category);
            })
        })

    }


    exposeCategory(category){
        this.posts.forEach((el) => {
            if(el.dataset.filter === category || 'all' === category){
                el.classList.remove('d-none');
            } else {
                el.classList.add('d-none');
            }
        })
    }
}