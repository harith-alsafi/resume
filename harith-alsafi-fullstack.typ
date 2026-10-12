// Typst port of harith-alsafi-fullstack.tex (altacv, 11pt, A4, 0.7cm margins).
// Compile: typst compile --font-path fonts harith-alsafi-fullstack.typ harith-alsafi-fullstack-typst.pdf
//
// Vertical layout mimics TeX: every text line is a fixed 13.55pt box (\baselineskip
// of 11pt extarticle), so baseline distances are 13.55pt + explicit v() skips.

// LaTeX sizes for 11pt (TeX pt -> PostScript pt)
#let normal = 10.91pt
#let footnote = 8.97pt
#let small = 9.96pt
#let large = 11.96pt
#let Large = 14.35pt
#let Huge = 24.79pt
#let tpt = 72pt / 72.27 // one TeX point
#let bskip = 13.6 * tpt // \baselineskip
#let top-edge = 0.7 * bskip // strut height
#let smallskip = 3 * tpt
#let medskip = 6 * tpt
#let itemsep = 0.25 * bskip
#let after-list = -0.35 * bskip // enumitem after=\vspace{-0.35\baselineskip}
#let ex = 5.52pt // 1ex of Lato at 11pt

// hyperref draws a cyan border around links in most viewers; replicate it.
#let show-link-borders = false

#set page(
  paper: "a4",
  // bottom margin is smaller than 0.7cm because TeX lets page 1's last line sit
  // below the text area (on its baseline); page breaks are explicit anyway.
  margin: (x: 0.7cm, top: 0.7cm, bottom: 0.3cm),
)
#set text(
  font: "Lato",
  size: normal,
  fill: black,
  lang: "en",
  hyphenate: true,
  top-edge: top-edge,
  bottom-edge: top-edge - bskip,
)
// TeX never kerns across inter-word glue; Lato's GPOS has space kern pairs.
#show " ": set text(kerning: false)
// TeX's Lato only ligates f-ligatures; the TTF also has "ti", "tt", etc.
#set text(ligatures: false)
#show regex("ff?[il]"): set text(ligatures: true)
#set par(leading: 0pt, spacing: 0pt, justify: false)
#set block(spacing: 0pt)
#set list(
  marker: text(size: small)[•],
  indent: 0pt,
  body-indent: 0.5em,
  spacing: itemsep,
)
#set strong(delta: 300)

// FontAwesome 4 glyphs used by altacv / the LaTeX fontawesome package
#let fa(code) = text(font: "FontAwesome", weight: "regular", code)
#let fa-marker = fa("\u{f041}") // \faMapMarker
#let fa-at = fa("\u{f1fa}") // \faAt
#let fa-chrome = fa("\u{f268}") // \faChrome
#let fa-github = fa("\u{f09b}") // \faGithub
#let fa-linkedin = fa("\u{f08c}") // \faLinkedinSquare
#let fa-calendar = fa("\u{f073}") // \faCalendar
#let fa-check = fa("\u{f14a}") // \faCheckSquare
#let fa-pin = fa("\u{f276}") // \faMapPin

#let lnk(url, body) = link(url, if show-link-borders {
  box(
    stroke: 1pt + rgb(0, 255, 255),
    outset: 1pt,
    text(top-edge: "bounds", bottom-edge: "bounds", body),
  )
} else { body })
#let sup(body) = text(size: 7.97pt, baseline: -3.96pt, body)

// A full-width, one-baselineskip tall line holding a drawn rule whose bottom
// sits `dy` below the baseline.
#let rule-line(rule, height) = block(
  width: 100%,
  height: bskip,
  place(top + left, dy: top-edge - height, rule),
)

// \cvsection: \medskip, \Large bold title, \\[-1ex], 2pt rule
#let section(title, pre: medskip) = {
  v(pre)
  par(text(size: Large, weight: "bold", title))
  v(-ex)
  rule-line(rect(width: 100%, height: 1.993pt, fill: black, stroke: none), 1.993pt)
}

// \tightdivider (hdashrule 0.6pt, 0.5ex dashes, body!30) incl. its trailing skip
#let dashes = rule-line(
  line(length: 549.78pt, stroke: (paint: luma(70%), thickness: 0.598pt, dash: (2.763pt, 2.763pt))),
  0.3pt,
)
#let divider = {
  v(after-list)
  dashes
  v(itemsep)
}

// \cvevent / \cveducation
#let event(title, sub: none, date: none, loc: none, loc-icon: fa-marker, sub-skip: 0pt) = {
  par[#text(size: large, weight: "bold", title)#if date != none [ #h(1fr)#fa-calendar#h(0.5em)#date]]
  if sub != none or loc != none {
    par[#sub#if loc != none [ #h(1fr)#loc-icon#h(0.5em)#loc]]
  }
  v(sub-skip)
}

// \cvtag: tikz node, 1ex x-sep, 0.75ex y-sep, rounded corners
#let tag(body) = box(
  inset: (x: ex),
  outset: (top: 12.44pt - top-edge, bottom: 5.52pt - (bskip - top-edge)),
  radius: 3.99pt,
  stroke: 0.3985pt + luma(60%),
  fill: luma(95%),
  body,
)
// a line of tags separated by two interword spaces + tikz outer sep
#let tag-row(lead, ..tags) = par(box(width: 600pt, lead + tags.pos().map(tag).join(h(5.98pt))))
#let tag-pitch = 19.35pt - bskip // lineskip kicks in between tag rows

// header item (\printinfo): icon, 0.5em, text, 1em
#let info(icon, body) = box[#icon#h(0.5em)#body#h(1em)]

// ---------------------------------------------------------------- header
#v(38.52pt - 19.84pt - top-edge)
#par[#text(size: Huge, weight: "bold")[Harith Al-Safi]#h(1fr)#text(size: footnote, weight: "bold")[#info(fa-marker)[Manchester, UK]#info(fa-at, lnk("mailto:harith.alsafi@gmail.com", "harith.alsafi@gmail.com"))#info(fa-chrome, lnk("https://harith.io/", "https://harith.io/"))]]
#v(16.94pt - bskip)
#par[#text(size: large, weight: "bold")[Full Stack Engineer]#h(1fr)#text(size: footnote, weight: "bold")[#info(fa-github, lnk("https://www.github.com/harith-alsafi", "github.com/harith-alsafi"))#info(fa-linkedin, lnk("https://www.linkedin.com/in/harith-al-safi", "linkedin.com/in/harith-al-safi"))]]

// ---------------------------------------------------------------- about
#section([About me], pre: 22.91pt - bskip)

A Full Stack Engineer with *5+ years* of experience specializing in *Java Spring Boot*, React.js, Machine Learning and Cloud Technologies. Proven record in leading technical teams and delivering *GraphQL* and *LLM-powered* platforms across *startup* to *enterprise*.

#v(smallskip)

// ---------------------------------------------------------------- experience
#section[Experience]

#event([Full Stack Engineer], sub: [BT Group], date: [Sep 2024 - Ongoing (2+ Years)], loc: [Manchester, UK])
- Owned a *GraphQL subgraph* on BT's *Apollo Federation Supergraph* end to end, from discovery to onboarding
- Ran a *consulting phase* with frontend and backend teams to unify multiple services behind *one GraphQL API*
- Demoed the subgraph to *400+ engineers*, showing fewer frontend round trips and no over-fetching
- Hardened *Spring Boot* services with *caching* and *circuit breakers*, deployed to *Kubernetes* via *Helm*
- Applied *AI-assisted development* with strict code review and testing to accelerate subgraph delivery
- Delivered 5 *Kafka-based Spring Boot microservices* with MongoDB/PostgreSQL, Netflix Conductor, and *Pulumi*
- Achieved *30% AWS cost reduction* by automating infrastructure with TypeScript and optimizing *ECS cluster*
- Re-architected Spring Boot APIs with JWT, *Azure AD*, and *role-based access* achieving *enterprise-grade security*
- Led *React.js to Next.js* migration of 5K+ lines, adding Cypress testing and OpenAPI to TypeScript *code gen*
- Mentored *5+ apprentices* in *Java 21* Spring Boot and ran the regional Graduate Network's monthly tech talks
#divider

#event([Technical Lead (Part-time)], sub: [Freelance], date: [Oct 2025 - Ongoing (1 Year)], loc: [Remote])
- Directed a team building a full-stack *AI document search platform* hosted on *Google Cloud (GCP)*
- Engineered a robust text-based *search engine with Elasticsearch* for fast, relevant document retrieval
- Evaluated *enterprise-grade LLMs* from *Gemma* to *Gemini* under strict data-protection requirements
- Tested multiple *document processing pipelines* to select the most accurate approach for LLM-based extraction
- Designed a *background queueing system* for LLM calls, turning *1–2 minute waits into instant responses* for users
#divider

#event([Lead Frontend Developer], sub: [Velz Travel], date: [Aug 2023 - Nov 2023 (4 Months)], loc: [Remote])
- Led the frontend of a travel web app for a startup built with *Redux Toolkit, Next.js* and *Material UI*
- Achieved 93% test coverage through comprehensive unit testing, resulting in *70% reduction in production bugs*
#divider

#event([Software Engineer], sub: [Johnson Controls], date: [Jul 2022 - Jul 2023 (12 Months)], loc: [London, UK])
- Invented a *scripting language with a compiler* for fire detection, increasing development productivity by 40%
- Managed a *team of 10* interns to create a *business plan* and ended up placing 2#sup[nd] amongst the whole company
- Administered C/C++ projects while fixing bugs, adding features, refactoring and *migrating 90% of codebase to C\#*
- Collaborated on an *analytics web dashboard with React.js* for predictive maintenance with DevOps and CI/CD
#divider

#event([Full Stack Developer], sub: [Paperound - Freelance], date: [Dec 2021 - May 2022 (6 Months)], loc: [Leeds, UK])
- Shipped a scalable analytics dashboard in Next.js, with *MSAL* and *Auth0* for seamless, secure authentication
- Built and trained a *reinforcement neural network* using *TensorFlow*, KerasRL for predicting market movements
- Created *regression models* with Python, *Scikit-learn* and Matplotlib, and presented to business *stakeholders*
#divider

#event([Information Technology Administrator], sub: [Mesopotamia Group], date: [Jun 2020 - Jun 2021 (12 Months)], loc: [Amman, Jordan])
- Developed a *high-availability load balancer with C/MPI* achieving 34% improved system uptime
- Built a *predictive analytics pipeline using Python* for proactive cybersecurity threat detection

// ---------------------------------------------------------------- education
// page 1 is full: explicit break, TeX-style \topskip on page 2
#pagebreak()
#v(10.96pt - top-edge)
#section([Education], pre: 0pt)

#event([BEng (Honours) in Electronics and Computer], sub: [University of Leeds (UoL)], date: [Sep 2019 - Jul 2024], loc: [First-Class Honours], loc-icon: fa-check, sub-skip: smallskip)
- Cloud and Parallel computing, Secure and Distributed systems, Cybersecurity, Software Engineering, Data Science
- Embedded systems, Microprocessors, FPGA, Circuit Analysis, Signal processing, Networking, Compiler design

// ---------------------------------------------------------------- skills
#section([Skills and Languages], pre: after-list + 2 * medskip)

#tag-row([*Backend*:#h(3.45pt)], [Java 21], [Spring Boot], [GraphQL], [Apollo Federation], [Kafka], [Conductor], [Python], [C\#])
#v(tag-pitch)
#tag-row([*Frontend*:#h(3.45pt)], [TypeScript], [React.js], [Next.js], [Redux], [Tailwind CSS], [Material UI], [Cypress], [Express.js])
#v(tag-pitch)
#tag-row([*ML / AI*:#h(3.45pt)], [LLMs (Gemini, Gemma)], [RAG], [Elasticsearch], [TensorFlow], [Scikit-learn], [XGBoost], [Pandas])
#v(tag-pitch)
#tag-row([*Cloud*:#h(3.45pt)], [GCP], [AWS (Lambda, ECS, RDS, S3)], [Azure (AD, Serverless)], [Kubernetes], [Helm], [Docker], [Pulumi])
#v(tag-pitch)
#tag-row([*Data / Tools*:#h(3.45pt)], [PostgreSQL], [MongoDB], [Redis], [Firestore], [SQLite], [Weaviate], [Jenkins], [Git], [Jira])
#dashes
#v(itemsep)
#tag-row([*Soft*:#h(3.45pt)], [Technical Leadership], [Mentoring], [Stakeholder Management], [Communication], [Problem solver])
#dashes
#v(itemsep)
#par[*Languages*:#h(3.45pt)*Arabic* (Full Professional) #h(1fr)*English* (Full Professional) #h(1fr)*Spanish* (Elementary)]

// ---------------------------------------------------------------- publications
#section([Publications], pre: 2 * medskip)

#event([Vega: LLM-driven Intelligent Chatbot Platform for Internet of Things Control and Development], sub: [MDPI Sensors - #lnk("https://www.mdpi.com/1424-8220/25/12/3809", "10.3390/s25123809") - 1#sup[st] Author], date: [2025])
- Delivered a full-stack *Chatbot* web application with TypeScript, React.js, Next.js, *Tailwind CSS* and *Redis*
- Programmed language processing algorithms using *multi-modal large language models* to execute user messages
- Implemented a *Python Flask* REST Server with *SQLite* on the *Raspberry Pi* to communicate with the chatbot
- Designed a *circuit* with sensors, camera, fans, LCD and buttons to execute user commands from the chatbot

// ---------------------------------------------------------------- projects
#section([Projects], pre: after-list + 2 * medskip)

#event([CV Studio], date: [Oct 2024 - Ongoing #h(1em)#fa-pin#h(5.58pt)Personal - Beta on #lnk("https://www.cvstudio.ai/", "cvstudio.ai")])
- Built a *full-stack* resume-improvement web app powered by LLMs, serving *hundreds of active users*
- Implemented *live resume editing* with ShadcnUI and Typst *WebAssembly* PDF compilation for real-time render
- Integrated *Clerk authentication* and *Stripe subscription* payments for secure user access and monetization
- Architected a RAG pipeline with *Weaviate vector DB* and *OpenAI embeddings* for resume analysis
#divider

#event([Green ML: Machine Learning for Green Bond Syndication], date: [May 2024 - Aug 2024 #h(1em)#fa-pin#h(5.58pt)Personal])
- Engineered bond syndication *prediction model* using *XGBoost* and network analysis on 3K+ institutional holders
- Implemented *parallel processing* with Ray to extract network features from adjacency matrices with *70% speedup*
- Built machine learning pipeline achieving *0.95+ AUC-ROC* for predicting bond syndication collaboration patterns
- Processed *Bloomberg financial data* using *pandas*, *NetworkX* for multi-regional investment analysis
#divider

#event([MCPP: High Performance C++ Library for Numerical Computation], date: [Apr 2021 - Oct 2022 #h(1em)#fa-pin#h(5.58pt)Personal])
- Created a *cross-platform math library* for C++ used for matrix algebra, statistics and machine learning
- Set up *CI/CD* using *Jenkins*, unit tests, Docker build, *CMake* and Doxygen documentation
- Improved performance by 40% using *parallel computing* with *OpenMP*, OpenCL and *CUDA*
