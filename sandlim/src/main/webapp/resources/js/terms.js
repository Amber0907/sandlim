document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('termsForm');
    const checkboxes = form.querySelectorAll('input[type="checkbox"]');
    const submitButton = document.getElementById('submitButton');
    const allAgreeCheckbox = document.getElementById('allAgree');

    function checkAgreement() {
        const allChecked = Array.from(checkboxes).filter(checkbox => checkbox.classList.contains('individual')).every(checkbox => checkbox.checked);
        submitButton.disabled = !allChecked;
    }

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            if (checkbox === allAgreeCheckbox) {
                const state = checkbox.checked;
                Array.from(checkboxes).forEach(cb => {
                    if (cb !== allAgreeCheckbox) {
                        cb.checked = state;
                    }
                });
            }
            checkAgreement();
        });
    });

    checkAgreement();
});