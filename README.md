
Rozwiązanie realizuje wymóg dostarczenia obrazu wspierającego architektury linux/amd64 oraz linux/arm64. Ze względu na ograniczenia Dockera, proces został rozbity na dwie fazy. Najpierw budowany jest lokalnie obraz pod jedną architekturę w celu wykonania testów, a po ich zaliczeniu uruchamiane jest właściwe budowanie multi-arch z bezpośrednim transferem do GitHub Container Registry.


Aby przyspieszyć czas trwania GitHub Actions przy każdorazowym commicie, wdrożono zewnętrzny mechanizm cache. Dane cache (warstwy bazowe,instrukcje pośrednie) są eksportowane w trybie max do prywatnego repozytorium na DockerHub. Dzięki przypisaniu im stałego tagu buildcache, pipeline nie tworzy bałaganu w rejestrze, a jednocześnie ma dostęp do najnowszych warstw, minimalizując zużycie zasobów. Gotowe obrazy aplikacji na ghcr.io są natomiast tagowane za pomocą skrótów commitów oraz tagiem latest.


Audyt CVE zrealizowano przy pomocy wtyczki Docker Scout Action. Konfiguracja wymusza kod błędu w przypadku wystąpienia podatności poziomu wysokiego lub krytycznego. Aby spełnić ten warunek, konieczne było zmodyfikowanie obrazu finalnego poprzez zmiane curla na wget-a.

