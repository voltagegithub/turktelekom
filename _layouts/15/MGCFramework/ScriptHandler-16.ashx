window.addEventListener('DOMContentLoaded', (e) => {
    var head = document.getElementsByTagName("HEAD")[0];
    var link = document.createElement("link");
    link.rel = "stylesheet";
    link.type = "text/css";
    link.href =
        "https://asset.turktelekom.com.tr/SiteAssets/javascript/modules/tt-blog/blog-style.css";
    head.appendChild(link);
});

function FisrtFunction() {
    document.addEventListener('DOMContentLoaded', function () {
        const checkboxes = document.querySelectorAll('.fieldsetCheckbox#authorFilterFieldset input[type="checkbox"]');

        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                updateUrl();
            });
        });

        function updateUrl() {
            const checkedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked);
            const checkboxNames = checkedCheckboxes.map(checkbox => checkbox.name);

            if (checkboxNames.length == 0) {
                const newUrl = window.location.pathname;
                window.history.replaceState({}, '', newUrl);

            } else {
                const newUrl = window.location.pathname + '?' + 'author=' + checkboxNames.join(',');
                window.history.replaceState({}, '', newUrl);
            }


        }

        // Sayfa yÃ¼klendiÄŸinde URL'deki query string'i kontrol et
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        const checkedCheckboxNames = urlParams.get('author');

        if (checkedCheckboxNames) {
            const decodedNames = checkedCheckboxNames.split(',');

            checkboxes.forEach(checkbox => {
                if (decodedNames.includes(checkbox.name)) {
                    checkbox.click();
                    checkbox.checked = true;
                    console.log("Checkbox ", checkbox, " is clicked ", checkbox.checked);
                    // checkbox.setAttribute("checked"); 
                }
            });
        }

    });
}

const TabController = () => {
    window.addEventListener('click', function (e) {
        if (e.target.closest('.tab .tab-link:not(.active)')) {
            const target = e.target.closest('.tab .tab-link:not(.active)');
            const categoryType = target.getAttribute('data-tabLink-trigger');
            const cardsPart = document.querySelector(target.closest('[data-tab]').dataset.tab);
            setTimeout(() => {
                document.querySelector(`#${target.closest('section').id}`).scrollIntoView();
            }, 10);
            target.closest('.tab').querySelectorAll('.tab-link').forEach(tab => { tab.classList.remove('active') });
            target.classList.add('active');
            hasPagination();
            if (categoryType.length === 0) {
                cardsPart.querySelectorAll(`[data-tabLink-target]`).forEach((card, index) => {
                    if (target.getAttribute('data-list-maxLimit')) {
                        +target.getAttribute('data-list-maxLimit') > index
                            ? card.classList.add('active')
                            : card.classList.remove('active');
                    }
                    else {
                        card.classList.add('active');
                    }
                });
                return false;
            }
            cardsPart.querySelectorAll(`[data-tabLink-target]`).forEach(card => {
                card.dataset.tablinkTarget === categoryType
                    ? card.classList.add('active')
                    : card.classList.remove('active');
            });
            LastCardWidth();
        }
    })

}
const hasPagination = () => {
    setTimeout(() => {
        if (document.querySelector('#pagination')) {
            let paginationHolder = $('#pagination').parent()
            paginationHolder.html('');
            paginationHolder.html('<ul id="pagination"></ul>');
            // perPage1 = 2;
            items = $(".main-card.active");
            itemCount = items.length;
            totalPage = Math.ceil(itemCount / perPage1);
            currentPage = totalPage < currentPage ? 1 : currentPage;
            $('#pagination').twbsPagination({
                totalPages: totalPage,
                visiblePages: seenPageCount,
                startPage: currentPage,
                first: '',
                prev: '<',
                next: '>',
                last: '',
                hideOnlyOnePage: true,
                onPageClick: function (event, page) {
                    displayItems(page, totalPage);
                }
            });
        }
    }, 100);
};

window.addEventListener('load', () => {
    limitVisibleCards();
});

window.addEventListener('click', function (event) {
    if (!event.target.matches('#ctl00_ctl67_g_be749fc9_e0a4_4f40_80fc_357de6a5a99e_ctl00_btnWp')) {
        limitVisibleCards(); 
    }
});


const LastCardWidth = () => {
    document.querySelectorAll('.cards').forEach(cardList => {
        setTimeout(() => {
            let activeCards = Array.from(cardList.querySelectorAll(':scope > .active'));
            if (activeCards.length > 1) {
                // let maxWidth = window.getComputedStyle(activeCards.at(-2)).getPropertyValue('max-width');
                let maxWidth = activeCards.at(-2).offsetWidth;
                activeCards.at(-1).style.maxWidth = maxWidth + 'px';
            }
        }, 100);
    })
}

const HamburgerMenuController = () => {
    document.querySelectorAll('.hamburger-trigger').forEach(hamburger => {
        hamburger.addEventListener('click', function () {
            document.querySelector('.hamburger-menu-wrapper').classList.toggle('active');
        })
    })
}
const HamburgerMenuController2 = () => {
    if (window.innerWidth > 980 && document.querySelector('.hamburger-menu-wrapper.active')) {
        document.querySelector('.hamburger-menu-wrapper').classList.remove('active');
    }
}
const AccordionController = () => {
    document.querySelectorAll('.accordion').forEach(accordion => {
        accordion.addEventListener('click', function () {
            accordion.classList.toggle('active');
        })
    })
}
const ModalController = () => {
    document.querySelectorAll('[data-modal-trigger]').forEach(modal => {
        modal.addEventListener('click', function () {
            document.querySelector(`#${modal.getAttribute('data-modal-trigger')}`).classList.add('active');
            document.querySelector('html').style.overflowY = 'hidden';
        });
    })
    document.querySelectorAll('.modal-close').forEach(modal => {
        modal.addEventListener('click', function () {
            modal.closest('.modal-content').classList.remove('active');
            document.querySelector('html').style.overflowY = 'unset';
        })
    })
};

const FilterController = () => {
    document.querySelectorAll('.filter-sort .trigger').forEach(trigger => {
        trigger.addEventListener('click', () => {
            document.querySelector('.filter-sort .trigger').classList.toggle('active');
        })
    })
    // document.querySelectorAll('.filter-sort input').forEach(input => {
    //     input.addEventListener('click', () => {
    //         if (input.type === "checkbox") {
    //             console.log(input.checked)
    //         }
    //         else if (input.type === "radio") {

    //         }
    //     })
    // })
    window.addEventListener('click', (e) => {
        const filterSortTrigger = document.querySelector('.filter-sort .trigger');
        const activeTrigger = document.querySelector(".filter-sort .trigger.active");

        if ((!e.target.closest(".filter-sort") && activeTrigger && activeTrigger.classList.contains("active")) || !filterSortTrigger?.classList.contains("active")) {

            if (e.target.closest('.filter-panel .result-filters .close')) {
                let target = e.target.closest('.filter-panel .result-filters .close');
                document.querySelector(`.filter-sort .filter-modal input[value="${target.closest('.bubble').querySelector('.type').innerText}"]`).click();
                target.closest('.bubble').remove();

            } else if (e.target.closest('.filter-panel .result-filters .bubble.clear-filters')) {
                if (!filterSortTrigger.classList.contains("active")) {
                    filterSortTrigger.classList.add('active');
                }
            } else {
                filterSortTrigger?.classList.remove('active');
            }
        } else if (e.target.closest('.filter-modal .btn-clear')) {
            let filters = e.target.closest('.filter-modal');
            filters.querySelectorAll('input[type=checkbox]:checked').forEach(input => {
                input.click();
            });
        }
    });



    window.addEventListener('change', (e) => {

        if (e.target.closest('.filter-panel .filter-sort input[type=checkbox]')) {
            let target = e.target.closest('.filter-panel .filter-sort input[type=checkbox]');
            if (target.checked) {
                let bubble = `
                <div class="bubble" data-value="${target.value}">
                    <div class="left">
                        <p class="category text-10 -text-mRtext-gray">Filtrele</p>
                        <p class="type text-14 -text-mSb">${target.value}</p>
                    </div>
                    <i class="close">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16"> <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"></path> </svg>
                    </i>
                </div>
                `;
                document.querySelector('.result-filters').insertAdjacentHTML('beforeend', bubble);
            }
            else {
                document.querySelectorAll('.bubble').forEach(bubble => {
                    if (bubble.dataset.value === target.value) {
                        bubble.remove();
                    }
                });
            }
            hasPagination();
            //console.log(target);
            FilterCategory();
        }
        else if (e.target.closest('.filter-panel .filter-sort input[type=radio]')) {
            let target = e.target.closest('.filter-panel .filter-sort input[type=radio]');
            // document.querySelectorAll('.result-filters .bubble').forEach(bubble => {
            //     bubble.querySelector('.category').innerText === 'SÃƒâ€Ã‚Â±rala' && (bubble.querySelector('.type').innerText = target.value);
            // });
            let sortedCards;
            if (target.id === "order-1") {
                sortedCards = Array.from(document.querySelectorAll('#blog-cards .main-card')).sort(function (a, b) {
                    return -a.getAttribute('data-sort').split('-')[0] + +b.getAttribute('data-sort').split('-')[0];
                });
            }
            else if (target.id === "order-2") {
                sortedCards = Array.from(document.querySelectorAll('#blog-cards .main-card')).sort(function (a, b) {
                    // console.log(a.getAttribute('data-sort').split('-')[0])
                    return +a.getAttribute('data-sort').split('-')[0] + -b.getAttribute('data-sort').split('-')[0];
                });
            }
            else if (target.id === "order-3") {
                sortedCards = Array.from(document.querySelectorAll('#blog-cards .main-card')).sort(function (a, b) {
                    return -a.getAttribute('data-sort').split('-')[1] + +b.getAttribute('data-sort').split('-')[1];
                });
            }
            sortedCards.forEach((card) => {
                document.querySelector('#blog-cards').appendChild(card);
            });
            hasPagination();
        }
    })
};

const FilterCategory = (categories) => {
    let categoryList = [];
    let authorList = [];
    Array.from(document.querySelectorAll('#categoryFilterFieldset input[type=checkbox]:checked')).forEach((category, index) => {
        categoryList.push(category.value);
    })
    Array.from(document.querySelectorAll('#authorFilterFieldset input[type=checkbox]:checked')).forEach((category, index) => {
        authorList.push(category.value);
    })
    document.querySelectorAll('.main-card').forEach((card) => {
        categoryList.length > 0
            ? (categoryList.includes(card.dataset.tablinkTarget) ? card.classList.add('active') : card.classList.remove('active'))
            : card.classList.add('active');
    });
    document.querySelectorAll('.main-card.active').forEach((card) => {
        authorList.length > 0
            ? (authorList.includes(card.dataset.authorTitle) ? card.classList.add('active') : card.classList.remove('active'))
            : card.classList.add('active');
    });
};
var urlHashControl = false;
const FilterAuthor = (authors) => {
    console.log("Yazarlar : ", authors);
    let authorList = [];
    Array.from(authors).forEach((author, index) => {
        authorList.push(author.value);
    })

    console.log(authorList);

    document.querySelectorAll('.main-card').forEach((card) => {
        authorList.length > 0
            ? (authorList.includes(card.dataset.authorTitle) ? card.classList.add('active') : card.classList.remove('active'))
            : card.classList.add('active');
    });
};

window.addEventListener('resize', function () {
    LastCardWidth();
    HamburgerMenuController2();
});
window.addEventListener('click', function (e) {
    if (e.target.closest('.page-item')) {
        LastCardWidth();
    }
});

const FilterCounter = () => {
    const cards = document.querySelectorAll('.main-card.type-01');
    if (document.querySelectorAll('.tab')[0]) {
        // console.log('tabs')
        cards.forEach((card, index) => {
            // console.log(card)
            index > 3
                && card.classList.remove('active');
        });
        document.querySelectorAll('.tab-link').forEach((tab, index) => {
            // console.log(tab)
            index != 0
                ? tab.closest('li').remove()
                : tab.querySelector('li .count').innerText = `(${cards.length})`;
        })
        objCategories.forEach((category, index) => {
            let categoryLength = document.querySelectorAll(`.main-card.type-01[data-tablink-target="${category}"`).length;
            if (categoryLength > 0) {
                let tabLinkHTML = `
                <li>
                    <a href="javascript:void(0);" class="tab-link flex gap-4 px-12 py-6" data-tablink-trigger="${category}">
                        <span class="name text-14 text-mSb">${category}</span>
                        <span class="count text-14 text-mSb">(${categoryLength})</span>
                    </a>
                </li>
                `
                document.querySelector('.tab').insertAdjacentHTML('beforeend', tabLinkHTML);
            }
        })
    }
    else if (document.querySelector('.filter-modal .fieldsetCheckbox')) {
        document.querySelectorAll('.filter-modal .fieldsetCheckbox#categoryFilterFieldset .checkbox').forEach((checkbox, index) => {
            checkbox.remove();
        })
        objCategories.forEach((category, index) => {
            let categoryLength = document.querySelectorAll(`.main-card.type-01[data-tablink-target="${category}"`).length;
            if (categoryLength > 0) {
                let checkboxHTML = `
                    <div class="checkbox">
                        <input type="checkbox" name="${category}-${index}" id="${category}-${index}" value="${category}">
                        <label for="${category}-${index}" class="text-14">${category} (${categoryLength})</label>
                    </div>
                `
                document.querySelector('.filter-modal .fieldsetCheckbox').insertAdjacentHTML('beforeend', checkboxHTML);
            }
        })
    }
    else if (document.querySelector('.filter-modal #authorFilterFieldset')) {
        document.querySelectorAll('.filter-modal #authorFilterFieldset .checkbox').forEach((checkbox, index) => {
            checkbox.remove();
        })
        objCategories.forEach((category, index) => {
            let categoryLength = document.querySelectorAll(`.main-card.type-01[data-tablink-target="${category}"`).length;
            if (categoryLength > 0) {
                let checkboxHTML = `
                    <div class="checkbox">
                        <input type="checkbox" name="${category}-${index}" id="${category}-${index}" value="${category}">
                        <label for="${category}-${index}" class="text-14">${category} (${categoryLength})</label>
                    </div>
                `
                document.querySelector('.filter-modal #authorFilterFieldset').insertAdjacentHTML('beforeend', checkboxHTML);
            }
        })
    }
};

const WebIntentAPI = () => {
    window.addEventListener('click', (e) => {
        let target = e.target.closest('.social-media a');
        if (target) {
            if (target.querySelector('img').getAttribute('alt') === 'Pinterest') {
                window.open(`https://www.pinterest.com/pin/create/button/?url=${window.location}&media=${window.origin}${document.querySelector('.banner-image source').getAttribute('srcset')}}&description=${document.querySelector('.content h2.title').innerText}`, '_blank');

            }
        }
    })
    document.querySelectorAll('.social-media a img').forEach(link => {
        if (link.getAttribute('alt') === 'Facebook') {
            link.closest('a').href = `https://www.facebook.com/sharer/sharer.php?u=${window.location}`;
            link.closest('a').setAttribute('target', '_blank');
        }
        else if (link.getAttribute('alt') === 'Twitter') {
            link.closest('a').href = `https://twitter.com/intent/tweet?text=${document.querySelector('.content h2.title').innerText}&url=${window.location}`;
            link.closest('a').setAttribute('target', '_blank');
        }
        else if (link.getAttribute('alt') === 'Linkedin') {
            link.closest('a').href = `https://www.linkedin.com/shareArticle?mini=true&url=${window.location}`;
            link.closest('a').setAttribute('target', '_blank');
        }
        else if (link.getAttribute('alt') === 'Instrgram' || link.getAttribute('alt') === 'Youtube') {
            link.closest('li').remove();
        }
    })
};



window.addEventListener('beforeunload', (e) => {
    const checkboxes = document.querySelectorAll('.filter-modal .fieldsetCheckbox input[type="checkbox"]');
    const radioButtons = document.querySelectorAll('.filter-modal .fieldsetCheckbox input[type="radio"]');
    const checkedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.name);
    const checkedRadioButtons = Array.from(radioButtons).filter(radioButton => radioButton.checked).map(radioButton => radioButton.name);
    const checkedValues = checkedCheckboxes.concat(checkedRadioButtons);
    localStorage.setItem('filterState', JSON.stringify(checkedValues));
});
window.addEventListener('DOMContentLoaded', (e) => {
    const savedState = localStorage.getItem('filterState');
    const activeFilters = savedState ? JSON.parse(savedState) : [];
    console.log(activeFilters)
    document.querySelectorAll('.filter-sort .fieldsetCheckbox input[type=checkbox]').forEach(input => {
        activeFilters.includes(input.name) && input.click();
        console.log(activeFilters.includes(input.name))
    });
});


//Filtreleri Temizle butonu
document.addEventListener("DOMContentLoaded", function () {
    const checkboxes = document.querySelectorAll('.filter-modal .fieldsetCheckbox input[type="checkbox"]');
    const radioButtons = document.querySelectorAll('.filter-modal .fieldsetCheckbox input[type="radio"]');
    const resultFilters = document.querySelector('.result-filters');
    const clearButton = document.querySelector('.filter-modal .btn-clear');
    let bubblesContainer;
    let clearBubble;

    function handleChange() {
        saveFiltersState();
        updateBubbles();
        updateCardVisibility(); // Diğer filtreler için kartların görünürlüğünü güncelle
    
        // #authorFilterFieldset alanındaki seçimleri de dikkate al
        const authorFilter = document.querySelector('#authorFilterFieldset input[type="radio"]:checked');
        if (authorFilter) {
            const authorValue = authorFilter.value;
            const cards = document.querySelectorAll('.main-card');
            cards.forEach(card => {
                if (card.dataset.author === authorValue) {
                    card.classList.add('active');
                } else {
                    card.classList.remove('active');
                }
            });
        }
    }
    

    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', handleChange);
    });

    radioButtons.forEach(function (radioButton) {
        radioButton.addEventListener('change', handleChange);
    });

    clearButton?.addEventListener('click', function () {
        saveFiltersState();
        clearAllBubbles();
    });

    resultFilters?.addEventListener('click', function (e) {
        if (e.target.classList.contains('bubble') && e.target.classList.contains('clear-filters')) {
            saveFiltersState();
            clearAllBubbles();
        } else if (e.target.closest('.bubble .close')) {
            let target = e.target.closest('.bubble');
            let value = target.getAttribute('data-value');
            let correspondingCheckbox = document.querySelector(`.filter-modal .fieldsetCheckbox input[value="${value}"]`);
            if (correspondingCheckbox) {
                correspondingCheckbox.checked = false;
            } else {
                let correspondingRadioButton = document.querySelector(`.filter-modal .fieldsetCheckbox input[type="radio"][value="${value}"]`);
                if (correspondingRadioButton) {
                    correspondingRadioButton.checked = false;
                }
            }
            target.remove();
            saveFiltersState();
            updateBubbles();

            // Kapanan bubble'a bağlı olan main-card-type sınıflarının aktifliğini kaldır
            const mainCardTypes = document.querySelectorAll(`.main-card.type-01[data-tablink-target="${value}"]`);
            mainCardTypes.forEach(mainCardType => {
                mainCardType.classList.remove('active');
            });

            // Tek bir bubble kaldığında, tüm main-card-type sınıflarını aktif hale getir
            const cards = document.querySelectorAll('.main-card.type-01');
            let anyActive = false;
            cards.forEach(card => {
                if (card.classList.contains('active')) {
                    anyActive = true;
                }
            });
            if (!anyActive) {
                cards.forEach(card => {
                    card.classList.add('active');
                });
            }

            hasPagination();
        }
    });

    window.addEventListener('DOMContentLoaded', function () {
        loadFiltersState();
        updateBubbles();
        updateCardVisibility();
    });

    function updateCardVisibility() {
        const authorCheckboxes = document.querySelectorAll('#authorFilterFieldset input[type="checkbox"]:checked');
        const categoryCheckboxes = document.querySelectorAll('#categoryFilterFieldset input[type="checkbox"]:checked');
        
        const selectedAuthors = Array.from(authorCheckboxes).map(checkbox => checkbox.value);
        const selectedCategories = Array.from(categoryCheckboxes).map(checkbox => checkbox.value);
    
        document.querySelectorAll('.main-card').forEach(card => {
            const authorTitle = card.dataset.authorTitle;
            const tablinkTarget = card.dataset.tablinkTarget;
    
            const isAuthorMatched = selectedAuthors.length === 0 || selectedAuthors.includes(authorTitle);
            const isCategoryMatched = selectedCategories.length === 0 || selectedCategories.includes(tablinkTarget);
    
            if (isAuthorMatched && isCategoryMatched) {
                card.classList.add('active');
            } else {
                card.classList.remove('active');
            }
        });
    }
    
    document.addEventListener('DOMContentLoaded', function () {
        updateCardVisibility();
    
        const authorCheckboxes = document.querySelectorAll('#authorFilterFieldset input[type="checkbox"]');
        const categoryCheckboxes = document.querySelectorAll('#categoryFilterFieldset input[type="checkbox"]');
    
        const checkboxes = [...authorCheckboxes, ...categoryCheckboxes];
    
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function () {
                updateCardVisibility(); 
            });
        });
    });
    
    function saveFiltersState() {
        const checkedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked).map(checkbox => checkbox.value);
        const checkedRadioButtons = Array.from(radioButtons).filter(radioButton => radioButton.checked).map(radioButton => radioButton.value);
        const checkedValues = checkedCheckboxes.concat(checkedRadioButtons);
        localStorage.setItem('filterState', JSON.stringify(checkedValues));
    }

    function loadFiltersState() {
        updateBubbles();
        const savedState = localStorage.getItem('filterState');
        if (savedState) {
            const checkedCheckboxes = JSON.parse(savedState);

            checkboxes.forEach(function (checkbox) {
                checkbox.checked = checkedCheckboxes.includes(checkbox.value);
            });

            radioButtons.forEach(function (radioButton) {
                if (!checkedCheckboxes.includes(radioButton.value)) {
                    radioButton.checked = false;
                }
            });

            checkboxes.forEach(function (checkbox) {
                if (checkbox.checked && checkbox.closest('.fieldsetCheckbox')) {
                    const value = checkbox.value;
                    const existingBubble = resultFilters.querySelector(`.bubble[data-value="${value}"]`);
                    if (!existingBubble) {
                        document.querySelector('.result-filters').insertAdjacentHTML('beforeend', `
                            <div class="bubble" data-value="${value}">
                                <div class="left">
                                    <p class="category text-10 -text-mRtext-gray">Filtrele</p>
                                    <p class="type text-14 -text-mSb">${value}</p>
                                </div>
                                <i class="close">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                        <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"></path>
                                    </svg>
                                </i>
                            </div>
                        `);
                    }
                }
            });
        } else {
            resultFilters.innerHTML = '';
        }

        resultFilters?.insertBefore(bubblesContainer, resultFilters.children[resultFilters.children.length - 1]);
    }

    function updateBubbles() {
        if (!bubblesContainer) {
            bubblesContainer = document.createElement('div');
            bubblesContainer.className = 'bubbles-container';
        }

        const hasCheckedCheckbox = Array.from(checkboxes).some(checkbox => checkbox.checked);
        const hasCheckedRadio = Array.from(radioButtons).some(radioButton => radioButton.checked);
        const checkedCheckboxesInsideFieldset = Array.from(document.querySelectorAll('.filter-modal .fieldsetCheckbox input[type="checkbox"]:checked'));

        if (!clearBubble && (resultFilters?.querySelector('.bubble') || hasCheckedCheckbox || hasCheckedRadio)) {
            clearBubble = document.createElement('div');
            clearBubble.className = 'bubble clear-filters';
            clearBubble.textContent = 'Filtreleri Temizle';
            clearBubble.addEventListener('click', function () {
                clearAllBubbles();
            });

            const firstBubble = resultFilters.querySelector('.bubble:not([data-value])');
            if (firstBubble) {
                resultFilters.insertBefore(bubblesContainer, firstBubble);
            } else {
                resultFilters.appendChild(bubblesContainer);
            }
        }

        const existingClearFilter = bubblesContainer.querySelector('.bubble.clear-filters');

        if (!existingClearFilter && resultFilters?.querySelector('.bubble')) {
            bubblesContainer.appendChild(clearBubble);
        }

        if (!hasCheckedCheckbox && !hasCheckedRadio) {
            const existingClearFilter = bubblesContainer?.querySelector('.bubble.clear-filters');
            if (existingClearFilter) {
                bubblesContainer.removeChild(existingClearFilter);
            }
            return;
        }
        if ((hasCheckedCheckbox || hasCheckedRadio) && bubblesContainer.children.length === 1) {
            bubblesContainer.appendChild(clearBubble.cloneNode(true));
        }

        const otherBubbles = bubblesContainer.querySelectorAll('.bubble:not(.clear-filters)');
        if (otherBubbles.length === 1 && otherBubbles[0].querySelector('.close')) {
            bubblesContainer.removeChild(existingClearFilter);
        }
    }

    function clearAllBubbles() {
        const cards = document.querySelectorAll('.main-card.type-01');
        cards.forEach(card => {
            card.classList.add('active');
        });
        resultFilters.innerHTML = '';
        checkboxes.forEach(function (checkbox) {
            checkbox.checked = false;
        });

        radioButtons.forEach(function (radioButton) {
            radioButton.checked = false;
        });

        const newUrl = window.location.pathname;
        window.history.replaceState({}, '', newUrl);
        localStorage.removeItem('filterState');

        bubblesContainer = null;
        clearBubble = null;

        hasPagination();
    }

    window.addEventListener('DOMContentLoaded', function () {
        const savedState = localStorage.getItem('filterState');
        if (!savedState) {
            document.querySelectorAll('.main-card.type-01').forEach(card => {
                card.classList.add('active');
            });
        } else {
            updateCardVisibility();
            const cards = document.querySelectorAll('.main-card.type-01');
            let anyActive = false;
            cards.forEach(card => {
                if (card.classList.contains('active')) {
                    anyActive = true;
                }
            });
            if (!anyActive) {
                cards.forEach(card => {
                    card.classList.add('active');
                });
            }
        }
        hasPagination();
    });

});


WebIntentAPI();
TabController();
LastCardWidth();
HamburgerMenuController();
HamburgerMenuController2();
AccordionController();
ModalController();
FisrtFunction();
FilterController();
FilterCounter();


// SEO ajansi talebiyle H1 basliklarini kaldirip H2'leri H1'e cevirme -od
document.addEventListener('DOMContentLoaded', function() {
    var pageHead = document.querySelector('.page-head');
    var h1B = pageHead.querySelector('h1');
    pageHead.removeChild(h1B);
  
    var h2B = document.querySelector('h2.text-mB');
    var newH1 = document.createElement('h1');
    newH1.textContent = h2B.textContent;
    newH1.classList.add('title', 'text-3224', 'text-mB');
    h2B.parentNode.replaceChild(newH1, h2B);
});;
