# Overview
I very much enjoyed the design and implementation of this assessment. You can check a production build demo [HERE](https://pennylane-test-web-soca.herokuapp.com/).

# Product
### Problem statement
It's dinner time! Create an application that helps users find the most relevant recipes they can prepare with the ingredients they have at home.

### Specification Proposal
- The recipe search should use a plain text search of ingredient English names. The system does not contain a predetermined well-defined set of ingredients (Not ingredient IDs).
- The search should only show recipes with at least one ingredient matched.
- The search order should be: First by recipes with fewer ingredients missing and then by the rating.
- Each recipe search result should show image, preparation time, cooking time, rating and missing ingredients.
- The search input should allow several ingredients.

# Tech Architecture

The live system is a classic Three-Tier Architecture with Frontend(React), Backend Server(Rails) and a Relational Database(Postgresql).
The code base follows a multi-repo split in this backend repo and the frontend repo.

### Frontend
- It was done as simple as possible, just for complementing the backend job.
- It uses React as the [bonus point](https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add#bonus-points) suggest.
- It follows a Single-page application architecture.
- The HTML is Client-side rendered.
- It supports Pagination.
- GitHub repo [Here](https://github.com/esoca/pennylane_test_web).

### Backend Server
- The API Base Url is ```https://pennylane-test-soca.herokuapp.com```
-  It uses a customized MVC (adding service and validation layer).
- Layers
  - Validation Layer (Tested)
  - Controller
  - Service (Tested)
  - Model (Tested)
  - View
- The API returns JSON responses.
- For persistence, It follows the ActiveRecord pattern instead of the Repository pattern.
- It supports Pagination.

### Relational Database
- Only one table.
- JSONB column for the list of ingredients for each recipe.

# Local Development

### Console 1
```
git clone https://github.com/esoca/pennylane_test
cd pennylane_test
make s
```

### Console 2
```
git clone https://github.com/esoca/pennylane_test_web
cd pennylane_test_web
npm start
```
