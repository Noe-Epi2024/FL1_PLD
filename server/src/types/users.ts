type User = {
    email: string;
    role: "utilisateur" | "admin";
    name: string;
    surname: string;
    birthDate: string;
    phoneNumber: string;
    photo: string;
}

type Credential = {
    email: string;
    password: string;
}

export { User, Credential };